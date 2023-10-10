//
//  NetworkResponse.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import Foundation

public protocol NetworkResponse: Codable, Encodable {}

extension Array: NetworkResponse where Element: NetworkResponse {}
