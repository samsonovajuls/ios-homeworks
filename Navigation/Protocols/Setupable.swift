//
//  Setupable.swift
//  Navigation
//
//  Created by Юлия Самсонова on 02.04.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
