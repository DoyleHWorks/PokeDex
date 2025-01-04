//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    private let fetcher: PokemonDetailFetcher
    private let disposeBag = DisposeBag()
    
    // Outputs
    let pokemonDetail = BehaviorRelay<PokemonDetail?>(value: nil)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String>()
    
    // MARK: - Initialization
    init(fetcher: PokemonDetailFetcher = PokemonDetailFetcher()) {
        self.fetcher = fetcher
    }

    func fetchDetail(id: Int) {
        isLoading.accept(true)
        fetcher.fetchPokemonDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.isLoading.accept(false)
                switch result {
                case .success(let detail):
                    self?.pokemonDetail.accept(detail)
                case .failure(let error):
                    self?.errorMessage.accept(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
