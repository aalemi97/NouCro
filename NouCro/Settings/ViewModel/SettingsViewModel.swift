//
//  SettingsViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation

class SettingsViewModel: ViewModelProvider {
    
    weak var view: Viewable?
    private var gridSize: Int = 0
    private var players: [Player] = []
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        setupSettingsData()
    }
    
    private func setupSettingsData() {
        let group = DispatchGroup()
        group.enter()
        GameParametersManager.shared.getGridSize { gridSize in
            self.gridSize = gridSize
            group.leave()
        }
        group.enter()
        GameParametersManager.shared.getPlayers { players in
            self.players = players
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.generateSettingsData()
        }
    }
    
    private func generateSettingsData() {
        let data = [
            MainSettingModel(title: "Grid Size", index: gridSize, minValue: 3, maxValue: 10),
            MainSettingModel(title: "Players Number", index: players.count, minValue: 2, maxValue: 9)
        ]
        view?.show(result: .success(data))
    }
}
