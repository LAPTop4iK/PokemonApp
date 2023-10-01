//
//  SceneDelegate.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo _: UISceneSession,
               options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene

        let rootViewController = MainTabBarAssembly.build()

        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
