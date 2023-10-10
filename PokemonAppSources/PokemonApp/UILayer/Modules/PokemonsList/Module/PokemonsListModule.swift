//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListModule: TabBarViewProtocol {
    var tabIcon = UIImage(systemName: "list.bullet")

    var tabTitle: String = "Лист покемонов"

    private let presenter = PokemonsListPresenter()
    private let view: PokemonsListViewInput

    init() {
        let networkManager = PokemonAPI()

        let interactor = PokemonsListInteractor()
        interactor.output = presenter
        interactor.pokemonApiManager = networkManager
        interactor.coreDataManager = DataStoreManager<ListPokemonEntity, PokemonDetail>()

        view = PokemonsListViewController()
        view.output = presenter

        presenter.view = view
        presenter.router = PokemonsListRouter()
        presenter.interactor = interactor
    }

    func configuredViewController() -> UIViewController {
        view.viewController
    }
}
