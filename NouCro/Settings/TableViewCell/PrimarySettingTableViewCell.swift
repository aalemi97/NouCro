//
//  PrimarySettingTableViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

class PrimarySettingTableViewCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    private var viewModel: PrimarySettingsCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with viewModel: any Reusable) {
        guard let viewModel = viewModel as? PrimarySettingsCellViewModel else { return }
        self.viewModel = viewModel
        titleLabel.text = viewModel.model.title
        indexLabel.text = "\(viewModel.model.value)"
        stepper.value = Double(viewModel.model.value)
        stepper.minimumValue = Double(viewModel.model.minValue)
        stepper.maximumValue = Double(viewModel.model.maxValue)
        return
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        indexLabel.text = "\(Int(sender.value))"
    }
    
}
