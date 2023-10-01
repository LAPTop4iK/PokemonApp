//
//  PokemonsListPresenter.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListPresenter {
    weak var view: PokemonsListViewInput!
    weak var output: PokemonsListModuleOutput?
    var interactor: PokemonsListInteractorInput!
    var router: PokemonsListRouterInput!

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension PokemonsListPresenter {
}

// MARK: - PokemonsListViewOutput
extension PokemonsListPresenter: PokemonsListViewOutput {
    func viewIsReady() {
        view.setupNavigationBar(title: "PokemonsList")
    }
    
    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - PokemonsListInteractorOutput
extension PokemonsListPresenter: PokemonsListInteractorOutput {
}
