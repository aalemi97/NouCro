//
//  PlayerCellViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation

class PlayerCellViewModel: NSObject, Reusable {
    
    typealias Model = Player
    private var model: Player
    private var cell: ReusableCell.Type
    
    required init(model: Player, cell: ReusableCell.Type) {
        self.model = model
        self.cell = cell
    }
    
    func getModel() -> Player {
        return model
    }
    
    func getReuseID() -> String {
        return cell.reuseID
    }
    
    func setPlayerName(_ name: String) {
        model.name = name
    }
    
    func setPlayerColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        model.color = .init(red: Float(red), green: Float(green), blue: Float(blue), alpha: Float(alpha))
    }
}