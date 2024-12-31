//
//  MainViewModel.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel {
    private let fetcher: PokemonListFetcher
    private let disposeBag = DisposeBag()
    private var offset = 0
    
    // Outputs
    let pokemonItems = BehaviorRelay<[PokemonListItem]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String>()
    
    init(fetcher: PokemonListFetcher = PokemonListFetcher()) {
        self.fetcher = fetcher
    }
    
    func fetchPokemons(limit: Int = 18) {
        guard !isLoading.value else { return } // 중복 요청 방지
        
        isLoading.accept(true)
        fetcher.fetchPokemonList(limit: limit, offset: offset)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.isLoading.accept(false)
                switch result {
                case .success(let items):
                    var currentItems = self?.pokemonItems.value ?? []
                    currentItems.append(contentsOf: items) // 기존 데이터와 병합
                    self?.pokemonItems.accept(currentItems)
                    self?.offset += limit // 오프셋 증가
                case .failure(let error):
                    if let networkError = error as? NetworkError {
                        self?.errorMessage.accept(networkError.localizedDescription)
                    } else {
                        self?.errorMessage.accept("Unexpected error: \(error.localizedDescription)")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
