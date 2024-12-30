//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Foundation

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Int
    let weight: Int
}

struct PokemonType: Decodable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Decodable {
    let name: String
}
