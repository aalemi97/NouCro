//
//  SettingViewerTableViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-11-15.
//

import UIKit

class SettingViewerTableViewCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    weak var valueLabel: UILabel?
    weak var iconImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with viewModel: any Reusable) {
        if let viewModel = viewModel as? PlayerCellViewModel {
            titleLabel.text = viewModel.playerName
            addImageView(withName: viewModel.playerIconName, tintColor: viewModel.playerColor.uiColor)
            return
        }
        if let viewModel = viewModel as? PrimarySettingCellViewModel {
            titleLabel.text = viewModel.title
            addValueLabel(withValue: viewModel.get(property: .current))
            return
        }
    }
    
    private func addImageView(withName imageName: String, tintColor: UIColor) {
        if let valueLabel {
            valueLabel.removeFromSuperview()
        }
        let imageView = UIImageView(image: UIImage(systemName: imageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tintColor
        imageView.contentMode = .center
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        iconImageView = imageView
    }
    
    private func addValueLabel(withValue value: Double) {
        if let iconImageView {
            iconImageView.removeFromSuperview()
        }
        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 15)
        valueLabel.text = "\(Int(value))"
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 10),
        ])
        self.valueLabel = valueLabel
    }
    
}
