//
//  GameParametersManager.swift
//  NouCro
//
//  Created by AliReza on 2024-10-28.
//

import Combine

class GameParametersManager: GameParametersProvider {
    
    static let shared = GameParametersManager()
    private var cancellables: Set<AnyCancellable> = []
    
    private init() {}
    
    func getPlayers(onCompletion: @escaping ([NCPlayer]) -> Void) {
        PersistenceManager.shared.get().sink { [weak self] result in
            switch result {
            case .finished:
                break
            case .failure(_):
                let players = self?.getDefaultPlayers() ?? []
                onCompletion(players)
            }
        } receiveValue: { (players: [NCPlayer]) in
            onCompletion(players)
        }.store(in: &cancellables)
        
    }
    
    func getGridSize(onCompletion: @escaping (NCGrid?) -> Void) {
        PersistenceManager.shared.get().sink { [weak self] result in
            switch result {
            case .finished:
                break
            case .failure(_):
                let size = self?.getDefaultGridSize()
                onCompletion(size)
            }
        } receiveValue: { (size: [NCGrid]) in
            onCompletion(size.first)
        }.store(in: &cancellables)
        
    }
    
    private func getDefaultPlayers() -> [NCPlayer] {
        let players =  [
            NCPlayer(name: "Annie", color: .init(mode: .pink), icon: "xmark"),
            NCPlayer(name: "Alex", color: .init(mode: .purple), icon: "circle")
        ]
        PersistenceManager.shared.save()
        return players
    }
    
    private func getDefaultGridSize() -> NCGrid {
        let size = NCGrid(dimension: 3)
        PersistenceManager.shared.save()
        return size
    }
}
