//
//  Presentable.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

protocol Presentable {
    var viewController: UIViewController { get }
}

extension Presentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
}
