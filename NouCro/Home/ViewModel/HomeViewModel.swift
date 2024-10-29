//
//  HomeViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import Foundation
import Combine

class HomeViewModel: ViewModelProvider {
    
    private weak var view: Viewable?
    public private(set) var gridSize: Int = 3
    private var players: [Player] = []
    private var actions: [Action] = []
    private var gameController: GameEngineProvider?
    private var turn: Int = 0 {
        didSet {
            currentPlayer.send(players[turn])
        }
    }
    private var currentPlayer: PassthroughSubject<Player, Never> = .init()
    var currentPlayerPublisher: AnyPublisher<Player, Never> {
        currentPlayer.eraseToAnyPublisher()
    }
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        setupGameEngine()
    }
    
    func setupGameEngine() {
        let group = DispatchGroup()
        group.enter()
        GameParametersManager.shared.getGridSize { [weak self] size in
            self?.gridSize = size
            group.leave()
        }
        group.enter()
        GameParametersManager.shared.getPlayers { [weak self] players in
            self?.players = players
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.createBoard()
        }
    }
    
    func didSelectItem(at index: Int) {
        guard actions[index] == .none(index: index) else { return }
        addAction(for: index)
    }
    
    func revertAction() -> Int {
        guard let index = gameController?.undo() else { return -1 }
        if index == -1 {
            return -1
        }
        turn = turn > 0 ? turn - 1 : players.count - 1
        actions[index] = .none(index: index)
        view?.show(result: .success(actions))
        return index
    }
    
    private func createBoard() {
        gameController = nil
        gameController = GameEngineController(playersNumber: Int32(players.count), gridSize: Int32(gridSize))
        actions = []
        for i in 0..<gridSize * gridSize {
            actions.append(.none(index: i))
        }
        view?.show(result: .success(actions))
        turn = 0
    }
    
    private func addAction(for index: Int) {
        let row: Int = index / gridSize
        let column: Int = index % gridSize
        guard let turn = gameController?.addMove([NSNumber(value: row), NSNumber(value: column)]) else { return }
        if (turn - 1) % 2 == 0 {
            actions[index] = .cross(index: index)
        } else {
            actions[index] = .nought(index: index)
        }
        view?.show(result: .success(actions))
        self.turn = turn
        currentPlayer.send(players[turn])
        gameDidEnd()
    }
    
    private func gameDidEnd() {
        guard let winner = gameController?.getWinner() else { return }
        if winner >= 0 {
            view?.show(result: .success("\(players[winner].name)"))
        } else if winner == -1 {
            view?.show(result: .success(""))
        }
        return
    }
}
