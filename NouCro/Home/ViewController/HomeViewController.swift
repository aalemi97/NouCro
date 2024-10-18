//
//  HomeViewController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    private var viewModel: ViewModelProvider
    
    required init?(coder: NSCoder, viewModel: ViewModelProvider) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }

}
