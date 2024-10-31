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
        let primarySettings = [
            PrimarySettingModel(title: "Grid Size", value: gridSize, minValue: 3, maxValue: 10),
            PrimarySettingModel(title: "Players Number", value: players.count, minValue: 2, maxValue: 9)
        ]
        let primarySection = primarySettings.map({ PrimarySettingsCellViewModel(model: $0, cellClass: PrimarySettingTableViewCell.self , reuseID: PrimarySettingTableViewCell.reuseID) })
        view?.show(result: .success(primarySection))
    }
}
