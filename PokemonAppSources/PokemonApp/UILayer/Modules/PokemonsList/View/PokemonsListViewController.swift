//
//  PokemonsListViewController.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListViewController: UIViewController {

    var output: PokemonsListViewOutput?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        output?.viewIsReady()
    }
}

// MARK: - PokemonsListViewInput
extension PokemonsListViewController: PokemonsListViewInput {
    func setupNavigationBar(title: String) {
        navigationController?.title = title
    }
}
