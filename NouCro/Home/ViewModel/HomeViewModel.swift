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
    private var actions: [Action] = []
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
        createBoard()
    }
    
    func createBoard() {
        for i in 0..<gridSize * gridSize {
            actions.append(.none(index: i))
        }
        view?.show(result: .success(actions))
    }
    
}
