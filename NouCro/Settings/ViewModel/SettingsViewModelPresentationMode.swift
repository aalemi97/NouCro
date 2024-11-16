//
//  SettingsViewModelPresentationMode.swift
//  NouCro
//
//  Created by AliReza on 2024-11-15.
//

import Foundation

enum SettingsViewModelPresentationMode {
    case viewer
    case editor
    
    var primarySettingCell: ReusableCell.Type {
        switch self {
        case .viewer:
            return SettingViewerTableViewCell.self
        case .editor:
            return PrimarySettingEditorTableViewCell.self
        }
    }
    
    var playerSettingCell: ReusableCell.Type {
        switch self {
        case .viewer:
            return SettingViewerTableViewCell.self
        case .editor:
            return PlayerEditorTableViewCell.self
        }
    }
}
