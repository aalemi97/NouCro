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
            if let source = data as? [MainSettingModel] {
                setupTableView(source)
                break
            }
            if let source = data as? [Player] {
                setupTableView(source)
            }
        case .failure(let error):
            print(error)
        }
        return
    }
    
    private func setupTableView(_ source: [MainSettingModel]) {
        self.dataSource = createDataSource()
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(source.map({ .main(model: $0) }), toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func setupTableView(_ source: [Player]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.players])
        snapshot.appendItems(source.map({ .player(model: $0) }), toSection: .players)
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
