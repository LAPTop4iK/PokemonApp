//
//  MainTabBarAssembly.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

final class MainTabBarAssembly {
    static func build() -> UITabBarController {
        let modules = [PokemonsListModule()]
        var viewControllers = [UINavigationController]()

        let tabbar = MainTabBarController()

        for module in modules {
            viewControllers.append(setupPageController(module: module))
        }

        tabbar.viewControllers = viewControllers

        return tabbar
    }
}

private extension MainTabBarAssembly {
    private static func setupPageController(module: TabBarViewProtocol) -> UINavigationController {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = module.tabIcon
        tabBarItem.title = module.tabTitle
        tabBarItem.accessibilityIdentifier = module.tabTitle

        let controller = module.configuredViewController()
        controller.tabBarItem = tabBarItem
        controller.title = module.tabTitle

        return UINavigationController(rootViewController: controller)
    }
}
