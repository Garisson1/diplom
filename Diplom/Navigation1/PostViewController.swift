//
//  PostViewController.swift
//  Navigation1
//
//  Created by home on 06.04.2022.
//

import UIKit


class PostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        let myButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapButton))
        self.navigationItem.rightBarButtonItem = myButton
        }

    @objc func didTapButton() {
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .fullScreen
        self.present(infoVC, animated: true)
    }
}
