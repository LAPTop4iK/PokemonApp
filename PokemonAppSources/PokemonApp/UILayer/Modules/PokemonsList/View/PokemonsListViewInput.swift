//
//  PokemonsListViewInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListViewInput: AnyObject, Presentable, Loadable {
    var output: PokemonsListViewOutput? { get set }

    func setupNavigationBar(title: String)
}
