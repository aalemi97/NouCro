//
//  Action.swift
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

import Foundation

enum Action: Hashable {
    
    case none(index: Int, image: String = "", color: String = "Black")
    case cross(index: Int, image: String = "xmark", color: String = "Pink")
    case nought(index: Int, image: String = "circle", color: String = "Purple")
    
    func getImage() -> String {
        switch self {
        case let .none(_, image, _):
            return image
        case let .cross(_, image, _):
            return image
        case let .nought(_, image, _):
            return image
        }
    }
    
    func getColor() -> String {
        switch self {
        case let .none(_, _, color):
            return color
        case let .cross(_, _, color):
            return color
        case let .nought(_, _, color):
            return color
        }
    }
}
