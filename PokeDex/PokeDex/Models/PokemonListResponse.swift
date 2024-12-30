//
//  PokemonListResponse.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

struct PokemonListResponse: Decodable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable {
    let name: String
    let url: String
    
    var id: Int? {
        guard let idString = url.split(separator: "/").last,
              let id = Int(idString) else {
            return nil
        }
        return id
    }
}
