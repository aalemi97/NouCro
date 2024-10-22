//
//  SettingsViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation

class SettingsViewModel: ViewModelProvider {
    
    weak var view: Viewable?
    private var gridSize: Int
    private var playersNumber: Int
    
    init(gridSize: Int, playersNumber: Int) {
        self.gridSize = gridSize
        self.playersNumber = playersNumber
    }
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
    }
}
