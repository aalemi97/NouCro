//
//  Action.swift
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

import Foundation

enum Action: Hashable {
    
    case none(index: Int)
    case play(index: Int, player: Player)
    
    func getImage() -> String {
        switch self {
        case .none(_):
            return ""
        case let .play(_, player):
            return player.icon
        }
    }
    
    func getColor() -> String {
        switch self {
        case .none(_):
            return "black"
        case let .play(_, player):
            return player.color
        }
    }
}
