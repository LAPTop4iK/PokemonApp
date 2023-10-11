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
    var model: ListPokemonModel?

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
    func getCellModelForRow(at indexPath: IndexPath) -> PokemonCellModel {
        guard let model = model?.details[indexPath.row] else {
            return PokemonCellModel(number: 0, name: "", elements: [], imageUrl: nil, delegate: self)
        }

        return PokemonCellModel(
            number: model.id,
            name: model.name,
            elements: model.types,
            imageUrl: model.imageUrl,
            delegate: self
        )
    }

    func didSelectRow(indexPath index: IndexPath) {
        navigateToDetailFor(id: index.row + 1)
    }

    func getNumberOfRows() -> Int {
        return model?.details.count ?? 0
    }

    func endOfPage(indexPath _: IndexPath) async {
        await paginator?.getData()
    }

    func refresh() {
        Task {
            await paginator?.refresh()
        }
    }


    func viewIsReady() async {
        paginator = Paginator(
            getData: { startIndex, batchSize in
                try? await self.interactor.getPokemons(startIndex: startIndex, countItems: batchSize)
            },
            onStart: {
                DispatchQueue.main.async {
                    self.view.showLoader()
                }
            },
            onNext: {
                DispatchQueue.main.async {
                    self.view.displayFooterLoader()
                }
            },
            onError: { error in
                self.getPokemonsFail(error: error.localizedDescription)
            }
        )

        await paginator?.getData()

        DispatchQueue.main.async {
            self.view.setupNavigationBar(title: "PokemonsList")
        }
    }

    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - PokemonsListInteractorOutput

extension PokemonsListPresenter: PokemonsListInteractorOutput {

    func getPokemonsSuccess(model: ListPokemonModel?) async {
        await self.updateModel(with: model)

        DispatchQueue.main.async {
            self.view.reload()
            self.view.hideFooterLoader()
            self.view.hideRefreshControl()
            self.view.hideLoader()
        }

        await paginator?.update(startIndex: self.model?.details.count ?? 0,
                                     responseSize: model?.details.count ?? 0)
    }

    func getPokemonsFail(error: String) {
        DispatchQueue.main.async {
            self.view.hideFooterLoader()
            self.view.hideRefreshControl()
            self.view.hideLoader()
            self.view.showAlert(msg: error)
        }
        Task {
            await self.paginator?.wasFail()
        }
    }
}

extension PokemonsListPresenter: ImageDownloaderDelegate {
    func setImageForImageView(_ imageView: UIImageView, imageURL: URL) {
        imageView.showRotationLoader(constantY: 0, needWhiteBackground: false)
        Task {
            do {
                if let image = try await interactor?.getImageWith(url: imageURL) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
                DispatchQueue.main.async {
                    imageView.hideRotationLoader()
                }
            }
        }
    }
}

private extension PokemonsListPresenter {
    func updateModel(with model: ListPokemonModel?) async {
        guard let model = model else { return }
        let firstBatch = await self.paginator?.firstBatch ?? true
        if firstBatch || self.model == nil {
            self.model = model
        } else {
            self.model?.updatePageWith(model: model)
        }
    }

    func navigateToDetailFor(id: Int) {
        router.showPokemonDetailFor(id: id, from: view.viewController)
    }
}
