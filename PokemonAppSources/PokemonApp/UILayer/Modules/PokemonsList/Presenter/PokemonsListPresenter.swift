//
//  PokemonsListPresenter.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListPresenter {
    private var paginator: Paginator?
    var model: PokemonList?

    struct DataSourceModel {
        var cellModel: PokemonCellModel
    }

    weak var view: PokemonsListViewInput!
    weak var output: PokemonsListModuleOutput?
    var interactor: PokemonsListInteractorInput!
    var router: PokemonsListRouterInput!

    private var closeView: (() -> Void)?
    private var closeImage: UIImage?
}

// MARK: - Present

extension PokemonsListPresenter {}

// MARK: - PokemonsListViewOutput

extension PokemonsListPresenter: PokemonsListViewOutput {
    func getCellModelForRow(at _: IndexPath) -> PokemonCellModel {
        return PokemonCellModel(
            number: 1,
            name: "Chandelure",
            elements: [
                ElementModel(color: .orange, iconImageName: "flame", name: "Fogo"),
                ElementModel(color: .blue, iconImageName: "ellipsis.message.fill", name: "Fantasma")

            ],
            iconName: "shoeprints.fill"
        )
    }

    func didSelectRow(indexPath _: IndexPath) {}

    func getNumberOfRows() -> Int {
        return 10
    }

    func endOfPage(indexPath _: IndexPath) {}

    func search(_: String) {}

    func didSetActive() {}

    func didSetNotActive() {}

    func refresh() {}

    func viewIsReady() {
        paginator = Paginator(
            getData: interactor.getPokemons,
            onStart: {},
            onNext: view.displayFooterLoader
        )
        paginator?.getData()
        view.setupNavigationBar(title: "PokemonsList")
    }

    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - PokemonsListInteractorOutput

extension PokemonsListPresenter: PokemonsListInteractorOutput {
    func getPokemonsSuccess(model: PokemonList) {
        view.hideFooterLoader()
        view.hideRefreshControl()

        updateModel(with: model)

//        self.view.displayModeMessages()
        view.reload()
//        if let ip = self.selectedIndexPath {
//            self.view.selectRowAt(ip)
//        }
    }

    func getPokemonsFail(error _: String) {}
}

private extension PokemonsListPresenter {
    private func updateModel(with model: PokemonList) {
        let firstBatch = true
        if firstBatch || self.model == nil {
            self.model = model
        } else {
            self.model?.updatePageWith(model: model)
        }
    }
}
