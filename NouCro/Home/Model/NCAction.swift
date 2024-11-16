//
//  NCAction.swift
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

import Foundation

enum NCAction: Hashable {
    
    case none(index: Int)
    case play(index: Int, player: NCPlayer)
    
    var image: String {
        switch self {
        case .none(_):
            return ""
        case let .play(_, player):
            return player.icon
        }
    }
    
    var color: NCColor {
        switch self {
        case .none(_):
            return .init(mode: .none)
        case let .play(_, player):
            return player.color
        }
    }
}
