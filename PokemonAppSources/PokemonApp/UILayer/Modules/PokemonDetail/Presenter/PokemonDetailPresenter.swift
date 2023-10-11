//
//  PokemonDetailPresenter.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonDetailPresenter {
    weak var view: PokemonDetailViewInput!
    weak var output: PokemonDetailModuleOutput?
    var interactor: PokemonDetailInteractorInput!
    var router: PokemonDetailRouterInput!
    var id: Int!

    private var closeView: (() -> Void)?
    private var closeImage: UIImage?
}

// MARK: - Present

extension PokemonDetailPresenter {
    func present(from vc: UIViewController) {
        view.present(from: vc, animated: true)
    }

    func presentAsNavController(from _: UIViewController) {
    }
}

// MARK: - PokemonDetailViewOutput

extension PokemonDetailPresenter: PokemonDetailViewOutput {
    func viewIsReady() async {
        DispatchQueue.main.async {
            self.view.setupNavigationBar(title: "PokemonsList")
            self.view.showLoader()
        }

        try? await interactor.getPokemonDetailFor(id: id)
    }

    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - PokemonDetailInteractorOutput

extension PokemonDetailPresenter: PokemonDetailInteractorOutput {
    func getPokemonDetailSuccess(model: DetailPokemonInfo?) {
        guard let model else { return }
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.view.configureViewWith(model: model, imageDelegate: self)
        }
    }

    func getPokemonDetailFail(error: String) {
        DispatchQueue.main.async {
            self.view.hideLoader()
            self.view.showAlert(msg: error)
        }
    }
}

extension PokemonDetailPresenter: ImageDownloaderDelegate {
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
