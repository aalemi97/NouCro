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
    private var grid: NCGrid? {
        willSet(newValue) {
            if let newValue {
                dimension.send(newValue.size)
            }
        }
    }
    private var players: [NCPlayer] = []
    private var actions: [Action] = []
    private var gameController: GameEngineProvider?
    private var turn: Int = 0 {
        didSet {
            currentPlayer.send(players[turn])
        }
    }
    private var dimension: PassthroughSubject<Int, Never> = .init()
    var dimensionPublisher: AnyPublisher<Int, Never> {
        dimension.eraseToAnyPublisher()
    }
    private var currentPlayer: PassthroughSubject<NCPlayer, Never> = .init()
    var currentPlayerPublisher: AnyPublisher<NCPlayer, Never> {
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
            self?.grid = size
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
        guard let gameController = gameController else { return -1 }
        let index = gameController.undo()
        if index == -1 {
            return -1
        }
        turn = gameController.getTurn()
        actions[index] = .none(index: index)
        view?.show(result: .success(actions))
        return index
    }
    
    private func createBoard() {
        guard let grid = grid else { return }
        gameController = nil
        gameController = GameEngineController(playersNumber: Int32(players.count), gridSize: Int32(grid.size))
        actions = []
        for i in 0..<grid.grid {
            actions.append(.none(index: i))
        }
        view?.show(result: .success(actions))
        turn = 0
    }
    
    private func addAction(for index: Int) {
        guard let size = grid?.size else { return }
        let row: Int = index / size
        let column: Int = index % size
        guard let turn = gameController?.addMove([NSNumber(value: row), NSNumber(value: column)]) else { return }
        actions[index] = .play(index: index, player: players[self.turn])
        view?.show(result: .success(actions))
        self.turn = turn
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
