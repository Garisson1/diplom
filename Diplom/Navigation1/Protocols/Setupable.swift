//
//  Setupable.swift
//  Navigation1
//
//  Created by home on 13.04.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

