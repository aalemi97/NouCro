//
//  SettingsViewController+Ext.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

extension SettingsViewController: Viewable {
    func show(result: Result<Any, NCError>) {
        switch result {
        case .success(let data):
            if let section = data as? [PrimarySettingsCellViewModel] {
                setupTableView(section)
                break
            }
        case .failure(let error):
            print(error)
        }
        return
    }
    
    private func setupTableView(_ section: [PrimarySettingsCellViewModel]) {
        self.dataSource = createDataSource()
        var snapshot = SnapShot()
        snapshot.appendSections([.primaries])
        snapshot.appendItems(section.map({ .primary(viewModel: $0) }), toSection: .primaries)
        dataSource.apply(snapshot)
    }
}

extension SettingsViewController: UITableViewDelegate {
    fileprivate func createDataSource() -> SettingsDataSource {
        let dataSource = SettingsDataSource(tableView: tableView)
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
