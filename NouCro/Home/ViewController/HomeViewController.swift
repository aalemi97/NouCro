//
//  HomeViewController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    private var viewModel: ViewModelProvider
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var colleccionView: UICollectionView!
    
    required init?(coder: NSCoder, viewModel: ViewModelProvider) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
