//
//  NCNavigationController.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

class NCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.ncPinkPurple
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.ncPink]
    }

}
