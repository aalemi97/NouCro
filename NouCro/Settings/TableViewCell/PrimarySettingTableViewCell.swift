//
//  PrimarySettingTableViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-21.
//

import UIKit
import Combine

class PrimarySettingTableViewCell: UITableViewCell, ReusableCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    private var viewModel: PrimarySettingsCellViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with viewModel: any Reusable) {
        guard let viewModel = viewModel as? PrimarySettingsCellViewModel else { return }
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        setStepper(with: viewModel.get(property: .current))
        stepper.minimumValue = viewModel.get(property: .min)
        stepper.maximumValue = viewModel.get(property: .max)
        viewModel.currentPublisher.sink { [weak self] value in
            self?.setStepper(with: Double(value))
        }.store(in: &cancellables)
        viewModel.maxPublisher.sink { [weak self] value in
            self?.stepper.maximumValue = Double(value)
        }.store(in: &cancellables)
        viewModel.minPublisher.sink { [weak self] value in
            self?.stepper.minimumValue = Double(value)
        }.store(in: &cancellables)
        return
    }
    
    private func setStepper(with value: Double) {
        stepper.value = value
        indexLabel.text = "\(Int(value))"
    }
    
    @IBAction func stepperDidChange(_ sender: UIStepper) {
        viewModel?.send(Int(sender.value))
    }
    
}
