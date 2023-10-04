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
    private var imageCache = [URL: UIImage]()
    var model: PokemonAPIResponse?

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
        guard let model = self.model?.details[indexPath.row] else {
            return PokemonCellModel(number: 0, name: "", elements: [], iconName: "", delegate: self)
        }
        
        return PokemonCellModel(
            number: model.id,
            name: model.name,
            elements: model.types,
            iconName: model.sprites.front_default,
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
        await self.paginator?.getData()
    }

    func search(_: String) {}

    func didSetActive() {}

    func didSetNotActive() {}

    func refresh() {}

    func viewIsReady() async {
            paginator = Paginator(
                getData: { startIndex, batchSize in
                    try? await self.interactor.getPokemons(startIndex: startIndex, countItems: batchSize)
                },
                onStart: {
                    DispatchQueue.main.async {
                        // Your UI update code for starting loading
                    }
                },
                onNext: {
                    DispatchQueue.main.async {
                        self.view.displayFooterLoader()
                    }
                },
                onError: { _ in }
            )
            
            // Using await to call asynchronous method getData from actor
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
//    @MainActor
    func getPokemonsSuccess(model: PokemonAPIResponse?) {
        updateModel(with: model)
        DispatchQueue.main.async {
            self.view.reload()
            self.view.hideFooterLoader()
            self.view.hideRefreshControl()
        }
        Task {
            await paginator?.update(startIndex: self.model?.details.count ?? 0, responseSize: model?.details.count ?? 0)
        }
    }

    func getPokemonsFail(error _: String) {}
}

extension PokemonsListPresenter: ImageDownloaderDelegate {
    func setImageForImageView(_ imageView: UIImageView, imageURL: URL) {
        if let image = imageCache[imageURL] {
            imageView.image = image
        } else {
//            imageView.showRotationLoader(constantY: 0)
            imageView.loadImageAsynchronouslyFrom(url: imageURL) { [weak self] image in
                if let img = image {
                    self?.imageCache[imageURL] = img
                }
//                imageView.hideRotationLoader()
            }
        }
        
    }
}

private extension PokemonsListPresenter {
    func updateModel(with model: PokemonAPIResponse?) {
        guard let model else { return }
        
        if self.model == nil {
            self.model = model
        } else {
            self.model?.updatePageWith(model: model)
        }
    }
    
    func navigateToDetailFor(id: Int) {
        router.showPokemonDetailFor(id: id, from: view.viewController)
    }
}
