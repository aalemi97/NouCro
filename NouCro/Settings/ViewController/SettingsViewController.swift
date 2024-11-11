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
    
    let viewModel: ViewModelProvider
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
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        let button = UIButton(type: .system)
        button.setTitle(" Back", for: .normal)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
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
        (viewModel as? SettingsViewModel)?.saveDatabase(onCompletion: { [weak self] shoulDismiss in
            if (shoulDismiss) {
                self?.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @objc
    func didTapBackButton(_ sender: UIButton) {
        (viewModel as? SettingsViewModel)?.resetDatabase();
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

}
