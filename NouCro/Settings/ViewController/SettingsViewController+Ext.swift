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
            guard let source = data as? [MainSettingModel] else { return }
            setupTableView(source)
        case .failure(let error):
            print(error)
        }
        return
    }
    
    private func setupTableView(_ source: [MainSettingModel]) {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MainSettingTableViewCell.reuseID, for: indexPath) as? MainSettingTableViewCell
            cell?.update(item)
            return cell
        })
        return dataSource
    }
}
