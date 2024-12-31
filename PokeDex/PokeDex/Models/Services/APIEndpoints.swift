//
//  APIEndpoints.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

struct APIEndpoints {
    static let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    static let imageBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/"
    
    static func mainViewList(limit: Int, offset: Int) -> String {
        return "\(baseURL)?limit=\(limit)&offset=\(offset)"
    }
    
    static func mainViewImage(id: Int) -> String {
        return "\(imageBaseURL)\(id).png"
    }
    
    static func detailView(id: Int) -> String {
        return "\(baseURL)\(id)/"
    }
}
