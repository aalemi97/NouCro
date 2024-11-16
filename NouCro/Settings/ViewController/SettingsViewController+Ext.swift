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
            if let section = data as? [PrimarySettingCellViewModel] {
                setupTableView(section)
                break
            }
            if let section = data as? [PlayerCellViewModel] {
                setupTableView(section)
            }
        case .failure(let error):
            print(error)
        }
        return
    }
    
    private func setupTableView(_ section: [PrimarySettingCellViewModel]) {
        self.dataSource = createDataSource()
        var snapshot = SnapShot()
        snapshot.appendSections([.primaries])
        snapshot.appendItems(section.map({ .primary(viewModel: $0) }), toSection: .primaries)
        dataSource.apply(snapshot)
    }
    private func setupTableView(_ section: [PlayerCellViewModel]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteSections([.players])
        snapshot.appendSections([.players])
        snapshot.appendItems(section.map({ .player(viewModel: $0) }), toSection: .players)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 55
        case 1:
            return 66
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.section != 0 else { return nil }
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            (self?.viewModel as? SettingsViewModel)?.removePlayer(at: indexPath.row) { value in
                completion(value)
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
