//
//  PokemonDetailFetcher.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Foundation
import RxSwift

final class PokemonDetailFetcher {
    func fetchPokemonDetail(id: Int) -> Single<PokemonDetail> {
        let url = APIEndpoints.detailView(id: id)
        return NetworkManager.shared.fetch(urlString: url)
    }
}
