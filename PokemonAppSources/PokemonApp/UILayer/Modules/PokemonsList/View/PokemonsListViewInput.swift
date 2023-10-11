//
//  PokemonsListViewInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListViewInput: AnyObject, Presentable, Loadable {
    var output: PokemonsListViewOutput? { get set }

    func reload()

    func displayFooterLoader()
    func hideFooterLoader()
    func hideRefreshControl()

    func selectRowAt(_ indexPath: IndexPath)
    func reloadRow(indexPath: IndexPath)
    func deleteRow(indexPath: IndexPath)

    func displayError(title: String, message: String, reloadBlock: (() -> Void)?)
    func setupNavigationBar(title: String)
}
