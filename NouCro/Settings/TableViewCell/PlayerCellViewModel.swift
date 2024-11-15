//
//  PlayerCellViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import Foundation
import Combine

class PlayerCellViewModel: NSObject, Reusable {
    
    typealias Model = Player
    private var model: Player
    private var cell: ReusableCell.Type
    private var iconButtonTapSubject: PassthroughSubject<Void, Never> = .init()
    var iconButtonTapPublisher: AnyPublisher<Void, Never> {
        iconButtonTapSubject.eraseToAnyPublisher()
    }
    var playerIconNamePublisher: AnyPublisher<String, Never> {
        model.iconPublihser
    }
    var playerName: String {
        return model.name
    }
    var playerColor: Color {
        return model.color
    }
    var storageModel: some Storable {
        return model
    }
    var playerIconName: String {
        return model.icon
    }
    
    required init(model: Player, cell: ReusableCell.Type) {
        self.model = model
        self.cell = cell
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
    
    func didSelectPlayerIconButton() {
        iconButtonTapSubject.send()
    }
}
