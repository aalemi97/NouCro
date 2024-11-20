//
//  SceneDelegate.swift
//  NouCro
//
//  Created by AliReza on 2024-10-11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = NCNavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator?.start()
    }

}

