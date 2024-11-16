//
//  SelectIconViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-11-13.
//

import Foundation

class SelectIconViewModel: ObservableObject {
    
    static let icons: [String] = ["circle", "circle.fill", "heart", "octagon", "shield", "square.fill", "triangle", "xmark", "xmark.seal.fill"]
    
    let color: NCColor
    private let player: NCPlayer
    @Published public private(set) var iconNames: [String] = []
    @Published public private(set) var selectedIconName: String {
        didSet {
            player.setIconName(selectedIconName)
        }
    }
    @Published var shouldDismiss: Bool = false
    
    init(player: NCPlayer) {
        self.player = player
        self.color = player.color
        self.selectedIconName = player.icon
        self.iconNames = SelectIconViewModel.icons
    }
    
    func didSelectItem(withName name: String) {
        self.selectedIconName = name
    }
}
