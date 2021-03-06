//
//  PhotosViewController.swift.swift
//  Navigation1
//
//  Created by home on 14.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    private enum Constants {
        static let itemCount: CGFloat = 3
    }

    var images = [UIImage]()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.collectionView)
        for i in 0...19 {
            if let image = UIImage(named: "G\(i)") {
            images.append(image)
            }
        }
        let topConstraint = self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leftConstraint = self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        NSLayoutConstraint.activate([
        topConstraint, leftConstraint, rightConstraint, bottomConstraint
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "?????? ??????????????"
    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let image = images[indexPath.item]
        cell.photoView.image = image
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let expandedCell = ExpandedPhotoCell()
        expandedCell.delegate = self
        self.view.addSubview(expandedCell)
        expandedCell.imageExpandedCell.image = images[indexPath.item]
        navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate([
            expandedCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandedCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expandedCell.topAnchor.constraint(equalTo: view.topAnchor),
            expandedCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                expandedCell.buttonCancel.alpha = 1
                expandedCell.backgroundColor = .black.withAlphaComponent(0.8)
            }
        }
    }
}

extension PhotosViewController: ExpandedCellDelegate {
    func pressedButton(view: ExpandedPhotoCell) {
        view.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
    }
}
