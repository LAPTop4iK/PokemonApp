//
//  PokemonsListViewOutput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListViewOutput {
    func viewIsReady() async
    func tapNavigationLeftBarButton()

    func didSelectRow(indexPath: IndexPath)
    func getCellModelForRow(at indexPath: IndexPath) -> PokemonCellModel
    func getNumberOfRows() -> Int
    func endOfPage(indexPath: IndexPath) async

    func refresh()
}
