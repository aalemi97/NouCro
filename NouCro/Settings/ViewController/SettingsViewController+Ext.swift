//
//  SettingsViewController+Ext.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

extension SettingsViewController: Viewable {
    func show(result: Result<Any, any Error>) {
        return
    }
    
    private func setupTableView(_ source: [SettingsModel]) {
        self.dataSource = createDataSource()
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(source, toSection: .main)
        dataSource.apply(snapshot)
    }
}

extension SettingsViewController: UITableViewDelegate {
    fileprivate func createDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        })
        return dataSource
    }
}
