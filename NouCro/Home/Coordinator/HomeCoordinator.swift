//
//  HomeCoordinator.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit
import Combine

class HomeCoordinator: Coordinator {
    private let navigationController: NCNavigationController
    private var childCoordinators: [Coordinator]
    private var cancellables: Set<AnyCancellable> = []
    
    required init(navigationController: NCNavigationController, childCoordinators: [Coordinator] = []) {
        self.navigationController = navigationController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.instantiate(viewModel: viewModel)
        viewController.settingsButtonTapPublisher.sink { [weak self] value in
            self?.pushSettingsViewController()
        }.store(in: &cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushSettingsViewController() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController.instantiate(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
