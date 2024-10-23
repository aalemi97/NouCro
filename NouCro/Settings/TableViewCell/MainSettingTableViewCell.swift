//
//  MainSettingTableViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit

class MainSettingTableViewCell: UITableViewCell {
    
    static let reuseID: String = String(describing: MainSettingTableViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(_ model: MainSettingModel) {
        titleLabel.text = model.title
        indexLabel.text = "\(model.index)"
        stepper.value = Double(model.index)
        stepper.minimumValue = Double(model.minValue)
        stepper.maximumValue = Double(model.maxValue)
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        indexLabel.text = "\(Int(sender.value))"
    }
    
}
