//
//  HomeCoordinator.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit
import Combine
import SwiftUI

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
        viewModel.playerIconTapPublisher.sink { [weak self] player in
            self?.pushSelectIconView(for: player)
        }.store(in: &cancellables)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushSelectIconView(for player: Player) {
        let viewModel = SelectIconViewModel(player: player)
        let viewController = UIHostingController(rootView: SelectIconView(viewModel: viewModel))
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .overCurrentContext
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        viewController.view.addGestureRecognizer(tap)
        viewController.modalTransitionStyle = .coverVertical
        viewModel.$shouldDismiss.sink { [weak self] value in
            value ? self?.dismiss() : nil
        }.store(in: &cancellables)
        navigationController.present(viewController, animated: true)
        return
    }
    
    @objc
    private func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
