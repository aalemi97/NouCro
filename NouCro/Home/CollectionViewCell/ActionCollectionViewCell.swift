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
        let color = model.getColor()
        actionImageView.tintColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
        actionImageView.image = UIImage(systemName: model.getImage())
    }

}
