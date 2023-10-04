//
//  String+.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import Foundation

extension String {
    var withoutNewlines: String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }
}
