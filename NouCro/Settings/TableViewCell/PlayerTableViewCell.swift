//
//  PlayerTableViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-30.
//

import UIKit
import Combine

class PlayerTableViewCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var colorPicker: UIColorWell!
    private var viewModel: PlayerCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorPicker.addTarget(self, action: #selector(colorPickerDidChange), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with viewModel: any Reusable) {
        guard let viewModel = viewModel as? PlayerCellViewModel else { return }
        self.viewModel = viewModel
        nameTextField.text = viewModel.getModel().name
        colorPicker.selectedColor = UIColor(hex: viewModel.getModel().color)
        return
    }
    
    @IBAction
    func textFieldDidEndEditing(_ sender: UITextField) {
        guard let name = sender.text, !name.isEmpty else { return }
        viewModel?.setPlayerName(name)
    }
    
    @objc
    private func colorPickerDidChange(_ sender: UIColorWell) {
        guard let color = sender.selectedColor else { return }
    }
}
