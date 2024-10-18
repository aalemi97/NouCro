//
//  Storyboarded.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

protocol Storyboarded: AnyObject {
    static var reuseIdentifier: String { get }
    static func instantiate(viewModel: ViewModelProvider) -> Self
    init?(coder: NSCoder, viewModel: ViewModelProvider)
}

extension Storyboarded where Self: UIViewController {
    static var reuseIdentifier: String { String(describing: Self.self) }
    static func instantiate(viewModel: ViewModelProvider) -> Self {
        let storyboard = UIStoryboard(name: reuseIdentifier, bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: reuseIdentifier) { coder in
            return Self.init(coder: coder, viewModel: viewModel)
        }
        return vc
    }
}
