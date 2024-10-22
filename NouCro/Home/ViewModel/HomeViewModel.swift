//
//  HomeViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import Foundation

class HomeViewModel: ViewModelProvider {
    
    private weak var view: Viewable?
    public private(set) var gridSize: Int = 3
    public private(set) var playersNumber: Int = 2
    private var actions: [Action] = []
    private var gameController: GameEngineProvider?
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        createBoard()
    }
    
    func createBoard() {
        gameController = nil
        gameController = GameEngineController(playersNumber: Int32(playersNumber), gridSize: Int32(gridSize))
        actions = []
        for i in 0..<gridSize * gridSize {
            actions.append(.none(index: i))
        }
        view?.show(result: .success(actions))
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
        actions[index] = .none(index: index)
        view?.show(result: .success(actions))
        return index
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
        gameDidEnd()
    }
    
    private func gameDidEnd() {
        guard let winner = gameController?.getWinner() else { return }
        if winner >= 0 {
            view?.show(result: .success("Player no#\(winner)"))
        } else if winner == -1 {
            view?.show(result: .success(""))
        }
        return
    }
}
