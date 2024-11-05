//
//  SettingsViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation
import Combine

class SettingsViewModel: ViewModelProvider {
    
    weak var view: Viewable?
    private var gridSizeSettings: PrimarySettingsCellViewModel?
    private var playersSettings: PrimarySettingsCellViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        retrieveSettingsData()
    }
    
    private func retrieveSettingsData() {
        var gridSize: Int = 0
        var players: [Player] = []
        let group = DispatchGroup()
        group.enter()
        GameParametersManager.shared.getGridSize { size in
            gridSize = size
            group.leave()
        }
        group.enter()
        GameParametersManager.shared.getPlayers { gamePlayers in
            players = gamePlayers
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.setupSettings(gridSize: gridSize, players: players)
        }
    }
    
    private func setupSettings(gridSize: Int, players: [Player]) {
        gridSizeSettings = PrimarySettingsCellViewModel(model: PrimarySettingModel(current: gridSize, min: 3, max: 10, title: "Grid Size"),
                                                        cell: PrimarySettingTableViewCell.self)
        gridSizeSettings?.valuePublisher.sink { [weak self] newValue in
            if Double(newValue) > self?.playersSettings?.get(property: .current) ?? Double(players.count) {
                self?.gridSizeSettings?.update(property: .current, withValue: newValue)
                self?.playersSettings?.update(property: .max, withValue: newValue - 1)
            }
        }.store(in: &cancellables)
        
        playersSettings = PrimarySettingsCellViewModel(model: PrimarySettingModel(current: players.count, min: 2, max: gridSize - 1, title: "Players Number"),
                                                       cell: PrimarySettingTableViewCell.self)
        playersSettings?.valuePublisher.sink { [weak self] newValue in
            self?.playersSettings?.update(property: .current, withValue: newValue)
            self?.gridSizeSettings?.update(property: .min, withValue: newValue + 1)
        }.store(in: &cancellables)
        view?.show(result: .success([gridSizeSettings, playersSettings]))
        let playersSection = players.map({ PlayerCellViewModel(model: $0, cell: PlayerTableViewCell.self) })
        view?.show(result: .success(playersSection))
    }
}
