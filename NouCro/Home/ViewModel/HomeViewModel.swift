//
//  HomeViewModel.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import Foundation

class HomeViewModel: ViewModelProvider {
    
    private weak var view: Viewable?
    
    func viewDidLoad(_ view: any Viewable) {
        self.view = view
    }
    
}
