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

    private var closeView: (() -> ())?
    private var closeImage: UIImage?
}

// MARK: - Present
extension PokemonDetailPresenter {
    func present(from vc: UIViewController) {
//        closeImage = UIImage(named: "back_arrow_black")
//        closeView = { [weak self] in
//            self?.view.viewController.navigationController?.popViewController(animated: true)
//        }
        self.view.present(from: vc, animated: true)
    }

    func presentAsNavController(from vc: UIViewController) {
//        closeImage = UIImage(named: "close_black")
//        closeView = { [weak self] in
//            self?.view.viewController.navigationController?.dismiss(animated: true)
//        }
//        view.presentAsNavController(from: vc)
    }
}

// MARK: - PokemonDetailViewOutput
extension PokemonDetailPresenter: PokemonDetailViewOutput {
    func viewIsReady() {
        view.setupNavigationBar(title: "PokemonDetail")
        
        let model = PokemonDetailModel(id: 1, types: [.init(type: .init(name: "flame"))], name: "Pikachu", sprites: .init(frontDefault: ""))
        
        view.configureViewWith(model: model)
    }
    
    func tapNavigationLeftBarButton() {
        closeView?()
    }
}

// MARK: - PokemonDetailInteractorOutput
extension PokemonDetailPresenter: PokemonDetailInteractorOutput {

}
