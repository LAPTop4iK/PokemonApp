//
//  PokemonsListModuleInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListModuleInput: AnyObject {
    func present(from viewController: UIViewController)
    func presentAsNavController(from vc: UIViewController)
}
