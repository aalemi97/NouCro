//
//  ActionCollectionViewCell.swift
//  NouCro
//
//  Created by AliReza on 2024-10-20.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    
    static let reuseID: String = String(describing: ActionCollectionViewCell.self)
    
    @IBOutlet weak var actionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .systemGray5
    }
    
    func update(model: Action) {
        actionImageView.tintColor = UIColor(named: model.getColor())
        actionImageView.image = UIImage(systemName: model.getImage())
    }

}
