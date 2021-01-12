//
//  PokemonModel.swift
//  PokexApp
//
//  Created by Gustavo Santos on 09/01/21.
//

import Foundation





public struct Pokemon: Decodable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let sprites: PokemonSprites
    let types: [PokemonTypes]
    let abilities: [PokemoAbilities]
}

public struct PokemonSprites: Decodable {
    let back_default: String
    let back_shiny: String
    let front_default: String
    let front_shiny: String
}


public struct PokemonTypes: Decodable {
    let slot: Int
    let type: Info

}

public struct PokemoAbilities: Decodable {
    let slot: Int
    let is_hidden: Bool
    let ability: Info
}

public struct Ability: Decodable {
    let effect_entries: [AbilityEntries]
}

public struct AbilityEntries: Decodable  {
    let effect: String
    let short_effect: String
    let language: Info
}


public struct Info: Decodable {
    let name: String
    let url: String

}


public struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Info]
    
}



