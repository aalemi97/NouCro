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
    
    typealias DataSource = UITableViewDiffableDataSource<TableViewSection, MainSettingModel>
    typealias SnapShot = NSDiffableDataSourceSnapshot<TableViewSection, MainSettingModel>
    
    @IBOutlet weak var tableView: UITableView!
    
    override var title: String? {
        get {
            "Settings"
        }
        set {}
    }
    
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
        setupTableView()
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        let nib = UINib(nibName: MainSettingTableViewCell.reuseID, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: MainSettingTableViewCell.reuseID)
        tableView.rowHeight = 44
    }
    
    @objc
    func didTapDoneButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
