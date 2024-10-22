//
//  SettingsViewController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {
    
    enum TableViewSection {
        case main
        case players
    }
    
    typealias DataSource = UITableViewDiffableDataSource<TableViewSection, SettingsModel>
    typealias SnapShot = NSDiffableDataSourceSnapshot<TableViewSection, SettingsModel>
    
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentView.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: ViewModelProvider
    var dataSource: DataSource!
    
    required init?(coder: NSCoder, viewModel: any ViewModelProvider) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(self)
    }
    
    private func setupTableView() {
        tableView.delegate = self
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
