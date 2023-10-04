//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonDetailModule {
    private let presenter = PokemonDetailPresenter()
    private let view: PokemonDetailViewInput

    init(id: Int) {
        let networkManager = PokemonAPI()
        let interactor = PokemonDetailInteractor()
        interactor.output = presenter
        interactor.pokemonApiManager = networkManager

        view = PokemonDetailViewController()
        view.output = presenter

        presenter.view = view
        presenter.router = PokemonDetailRouter()
        presenter.interactor = interactor
        presenter.id = id
    }
}

// MARK: PokemonDetailModuleInput
extension PokemonDetailModule: PokemonDetailModuleInput {
    func presentAsNavController(from vc: UIViewController) {
        presenter.presentAsNavController(from: vc)
    }
    
    func present(from vc: UIViewController) {
        presenter.present(from: vc)
    }
}
