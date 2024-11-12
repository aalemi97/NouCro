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
        let color = viewModel.getModel().color
        colorPicker.selectedColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
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
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        roundRGBValues(red: &red, green: &green, blue: &blue, alpha: &alpha)
        viewModel?.setPlayerColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func roundRGBValues(red: inout CGFloat, green: inout CGFloat, blue: inout CGFloat, alpha: inout CGFloat) {
        red = round(red * 1000) / 1000
        green = round(green * 1000) / 1000
        blue = round(blue * 1000) / 1000
        alpha = round(alpha * 1000) / 1000
    }
}
