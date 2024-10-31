//
//  ReusableCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation

protocol ReusableCell {
    static var reuseID: String { get }
    func update(with viewModel: any Reusable)
}

extension ReusableCell {
    static var reuseID: String {
        String(describing: Self.self)
    }
}
