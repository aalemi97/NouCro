//
//  HomeCoordinator.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let navigationController: NCNavigationController
    private var childCoordinators: [Coordinator]
    
    required init(navigationController: NCNavigationController, childCoordinators: [Coordinator] = []) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.instantiate(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
