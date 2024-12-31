//
//  PokemonListFetcher.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import RxSwift

final class PokemonListFetcher {
    func fetchPokemonList(limit: Int, offset: Int) -> Single<[PokemonListItem]> {
        let urlString = APIEndpoints.mainViewList(limit: limit, offset: offset)
        return NetworkManager.shared.fetch(urlString: urlString)
            .map { (response: PokemonListResponse) in response.results }
            .catch { error in
                if let networkError = error as? NetworkError {
                    return Single.error(networkError)
                }
                return Single.error(NetworkError.unknown(error))
            }
    }
}
