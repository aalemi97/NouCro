//
//  SettingsDataSource.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import UIKit

enum SettingsTableViewSection: String, CaseIterable {
    case main = "Main"
    case players = "Players"
}

enum SettingsModel: Hashable {
    case main(model: MainSettingModel)
    case player(model: Player)
}

class SettingsDataSource: UITableViewDiffableDataSource<SettingsTableViewSection, SettingsModel> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .main(model: let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: MainSettingTableViewCell.reuseID, for: indexPath) as? MainSettingTableViewCell
                cell?.update(model)
                return cell
            case .player(model: let model):
                return UITableViewCell()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsTableViewSection.allCases[section].rawValue
    }
}
