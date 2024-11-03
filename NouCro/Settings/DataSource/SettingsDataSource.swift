//
//  SettingsDataSource.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import UIKit

enum SettingsTableViewSection: String, CaseIterable {
    case primaries = "Primary Settings"
    case players = "Players"
}

enum SettingsModel: Hashable {
    case primary(viewModel: PrimarySettingsCellViewModel)
    case player(viewModel: PlayerCellViewModel)
}

class SettingsDataSource: UITableViewDiffableDataSource<SettingsTableViewSection, SettingsModel> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case let .primary(viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.getReuseID(), for: indexPath)
                (cell as? ReusableCell)?.update(with: viewModel)
                return cell
            case let .player(viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.getReuseID(), for: indexPath)
                (cell as? ReusableCell)?.update(with: viewModel)
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsTableViewSection.allCases[section].rawValue
    }
}
