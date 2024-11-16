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
        setupBarButtonItemForViewerMode()
    }
    
    private func setupBarButtonItemForViewerMode() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        let button = UIButton(type: .system)
        button.setTitle(" Back", for: .normal)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
        tableView.allowsSelection = false
    }
    
    private func setupBarButtonItemForEditorMode() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.allowsSelection = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        let viewerCellNib = UINib(nibName: SettingViewerTableViewCell.reuseID, bundle: .main)
        tableView.register(viewerCellNib, forCellReuseIdentifier: SettingViewerTableViewCell.reuseID)
        let primaryCellNib = UINib(nibName: PrimarySettingEditorTableViewCell.reuseID, bundle: .main)
        tableView.register(primaryCellNib, forCellReuseIdentifier: PrimarySettingEditorTableViewCell.reuseID)
        let playerCellNib = UINib(nibName: PlayerEditorTableViewCell.reuseID, bundle: .main)
        tableView.register(playerCellNib, forCellReuseIdentifier: PlayerEditorTableViewCell.reuseID)
        tableView.sectionHeaderHeight = 44
    }
    
    @objc
    private func didTapEditButton(_ sender: UIButton) {
        (viewModel as? SettingsViewModel)?.setPresentationMode(to: .editor)
        setupBarButtonItemForEditorMode()
    }
    
    @objc
    private func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapDoneButton(_ sender: UIButton) {
        (viewModel as? SettingsViewModel)?.saveDatabase(onCompletion: { [weak self] completed in
            if (completed) {
                (self?.viewModel as? SettingsViewModel)?.setPresentationMode(to: .viewer)
                self?.setupBarButtonItemForViewerMode()
            }
        })
    }
    
    @objc
    private func didTapCancelButton(_ sender: UIButton) {
        (viewModel as? SettingsViewModel)?.resetDatabase()
        (viewModel as? SettingsViewModel)?.setPresentationMode(to: .viewer)
        setupBarButtonItemForViewerMode()
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

}
