//
//  PokemonModel.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation





public struct Pokemon: Decodable {
    let height: Int
    let id: Int
}




public struct PokemonList: Decodable {
    let count: Int
    let next: String
    let previous: String
    let results: [PokemonUnitList]
    
}


public struct PokemonUnitList: Decodable {
    let name: String
    let url: String

}

