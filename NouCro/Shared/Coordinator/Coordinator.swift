//
//  Coordinator.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import Foundation

protocol Coordinator: AnyObject {
    init(navigationController: NCNavigationController, childCoordinators: [Coordinator])
    func start()
}
