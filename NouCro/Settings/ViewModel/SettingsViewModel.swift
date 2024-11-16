//
//  SettingsViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import Foundation
import Combine

class SettingsViewModel: ViewModelProvider {
    // MARK: - Properties
    weak var view: Viewable?
    private var gridSize: NCGrid?
    private var gridSizeSetting: PrimarySettingCellViewModel?
    private var playersSection: [PlayerCellViewModel] = [] {
        didSet {
            view?.show(result: .success(playersSection))
            self.playersSetting?.update(property: .current, withValue: playersSection.count)
            self.gridSizeSetting?.update(property: .min, withValue: playersSection.count + 1)
        }
    }
    private var playersSetting: PrimarySettingCellViewModel?
    private var cancellables: Set<AnyCancellable> = []
    private var playerIconTapSubject: PassthroughSubject<NCPlayer, Never> = .init()
    var playerIconTapPublisher: AnyPublisher<NCPlayer, Never> {
        playerIconTapSubject.eraseToAnyPublisher()
    }
    
    var presentationMode: SettingsViewModelPresentationMode = .viewer
    
    // MARK: - Public methods
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        retrieveSettingsData()
    }
    
    func removePlayer(at index: Int, onCompletion: @escaping ((Bool) -> Void)) {
        guard playersSection.count > 2, index < playersSection.count else { return }
        PersistenceManager.shared.delete(data: playersSection[index].storageModel).sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.description)
            }
        } receiveValue: {[weak self] value in
            if value {
                self?.playersSection.remove(at: index)
            }
            onCompletion(value)
        }.store(in: &cancellables)
    }
    
    func saveDatabase(onCompletion: @escaping (Bool) -> Void) {
        PersistenceManager.shared.save().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.description)
                onCompletion(false)
            }
        } receiveValue: { value in
            onCompletion(value)
        }.store(in: &cancellables)
    }
    
    func resetDatabase() {
        PersistenceManager.shared.resetDatabase()
    }
    
    func setPresentationMode(to presentationMode: SettingsViewModelPresentationMode) {
        self.presentationMode = presentationMode
        cancellables.forEach({$0.cancel()})
        cancellables.removeAll()
        retrieveSettingsData()
    }
    
    // MARK: - Private methods
    private func retrieveSettingsData() {
        var players: [NCPlayer] = []
        let group = DispatchGroup()
        group.enter()
        GameParametersManager.shared.getGridSize { [weak self] gridSize in
            self?.gridSize = gridSize
            group.leave()
        }
        group.enter()
        GameParametersManager.shared.getPlayers { gamePlayers in
            players = gamePlayers
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.setupSettings(players: players)
        }
    }
    
    private func setupSettings(players: [NCPlayer]) {
        setupGridSizeSetting()
        setupPlayersSetting(with: players)
        view?.show(result: .success([gridSizeSetting!, playersSetting!]))
        playersSection = players.map({ createNewRow(for: $0) })
    }
    
    private func createNewRow(for player: NCPlayer) -> PlayerCellViewModel {
        let viewModel = PlayerCellViewModel(model: player, cell: presentationMode.playerSettingCell)
        viewModel.iconButtonTapPublisher.sink { [weak self] in
            self?.playerIconTapSubject.send(player)
        }.store(in: &cancellables)
        return viewModel
    }
    
    private func setupGridSizeSetting() {
        guard let size = self.gridSize?.size else { return }
        gridSizeSetting = PrimarySettingCellViewModel(model: PrimarySettingModel(current: Int(size), min: 3, max: 10, title: "Grid Size"), cell: presentationMode.primarySettingCell)
        gridSizeSetting?.valuePublisher.sink { [weak self] newValue in
            self?.gridSize?.dimension = Int16(newValue)
            self?.gridSizeSetting?.update(property: .current, withValue: newValue)
            self?.playersSetting?.update(property: .max, withValue: newValue - 1)
        }.store(in: &cancellables)
    }
    
    private func setupPlayersSetting(with players: [NCPlayer]) {
        guard let size = self.gridSize?.size else { return }
        playersSetting = PrimarySettingCellViewModel(model: PrimarySettingModel(current: players.count, min: 2, max: Int(size) - 1, title: "Players Number"), cell: presentationMode.primarySettingCell)
        playersSetting?.valuePublisher.sink { [weak self] newValue in
            if newValue > self?.playersSection.count ?? 0 {
                self?.addNewPlayer()
            } else {
                self?.removePlayer(at: newValue) { _ in }
            }
        }.store(in: &cancellables)
    }
    
    private func addNewPlayer() {
        let player = NCPlayer()
        let newRow = createNewRow(for: player)
        self.playersSection.append(newRow)
    }
}
