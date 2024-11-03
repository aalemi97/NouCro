//
//  SettingsViewController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<SettingsTableViewSection, SettingsModel>
    
    @IBOutlet weak var tableView: UITableView!
    
    override var title: String? {
        get {
            "Settings"
        }
        set {}
    }
    
    private let viewModel: ViewModelProvider
    var dataSource: SettingsDataSource!
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        let primaryCellNib = UINib(nibName: PrimarySettingTableViewCell.reuseID, bundle: .main)
        tableView.register(primaryCellNib, forCellReuseIdentifier: PrimarySettingTableViewCell.reuseID)
        let playerCellNib = UINib(nibName: PlayerTableViewCell.reuseID, bundle: .main)
        tableView.register(playerCellNib, forCellReuseIdentifier: PlayerTableViewCell.reuseID)
        tableView.sectionHeaderHeight = 44
    }
    
    @objc
    private func didTapDoneButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

}
