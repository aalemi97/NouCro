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
    
    func getPlayers(onCompletion: @escaping ([Player]) -> Void) {
        PersistenceManager.shared.get().sink { [weak self] result in
            switch result {
            case .finished:
                break
            case .failure(_):
                let players = self?.getDefaultPlayers() ?? []
                onCompletion(players)
            }
        } receiveValue: { (players: [Player]) in
            onCompletion(players)
        }.store(in: &cancellables)
        
    }
    
    func getGridSize(onCompletion: @escaping (Int) -> Void) {
        PersistenceManager.shared.get().sink { [weak self] result in
            switch result {
            case .finished:
                break
            case .failure(_):
                let size = self?.getDefaultGridSize()
                onCompletion(Int(size?.size ?? 0))
            }
        } receiveValue: { (size: [GridSize]) in
            onCompletion(Int(size.first?.size ?? 0))
        }.store(in: &cancellables)
        
    }
    
    private func getDefaultPlayers() -> [Player] {
        let players =  [
            Player(name: "Annie", color: "#663DFF", icon: "xmark"),
            Player(name: "Alex", color: "#CC4499", icon: "circle")
        ]
        PersistenceManager.shared.save()
        return players
    }
    
    private func getDefaultGridSize() -> GridSize {
        let size = GridSize(size: 3)
        PersistenceManager.shared.save()
        return size
    }
}
