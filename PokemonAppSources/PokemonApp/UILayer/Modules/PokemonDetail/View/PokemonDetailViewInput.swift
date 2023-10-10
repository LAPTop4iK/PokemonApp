//
//  PokemonDetailViewInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonDetailViewInput: UIViewController, Loadable, Presentable {
    var output: PokemonDetailViewOutput? { get set }

    func setupNavigationBar(title: String)

    func configureViewWith(model: DetailPokemonInfo, imageDelegate: ImageDownloaderDelegate)
}
