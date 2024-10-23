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
        generateSettingsData()
    }
    
    func generateSettingsData() {
        let data = [
            MainSettingModel(title: "Grid Size", index: 3, minValue: 3, maxValue: 10),
            MainSettingModel(title: "Players Number", index: 2, minValue: 2, maxValue: 9)
        ]
        view?.show(result: .success(data))
    }
}
