//
//  MainViewController.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        $0.collectionViewLayout = layout
        $0.backgroundColor = .pdRedDark
        $0.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        setupInfiniteScroll()
        viewModel.fetchPokemons()
    }
    
    private func setupUI() {
        view.backgroundColor = .pdRedMain
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        // Bind collectionView items
        viewModel.pokemonItems
            .bind(to: collectionView.rx.items(
                cellIdentifier: PokemonCollectionViewCell.identifier,
                cellType: PokemonCollectionViewCell.self)
            ) { index, item, cell in
                cell.configure(with: item)
            }
            .disposed(by: disposeBag)
        
        // Handle errors
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { isLoading in
                if isLoading {
                    print("Loading...")
                } else {
                    print("Loading complete.")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupInfiniteScroll() {
        collectionView.rx.contentOffset
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] offset in
                guard let self = self else { return }
                let contentHeight = self.collectionView.contentSize.height
                let frameHeight = self.collectionView.frame.size.height
                let yOffset = offset.y
                
                if yOffset > contentHeight - frameHeight - 300 { // 마지막 300pt에서 추가 로드
                    self.viewModel.fetchPokemons()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 10 * 2 + 10 * 2 // 좌우 섹션 inset + 셀 간 간격
        let width = (collectionView.bounds.width - CGFloat(totalSpacing)) * 0.33 // 화면 너비의 33%
        return CGSize(width: width, height: width * 1.6) // 원하는 비율 (1.4배 높이)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 섹션 여백
    }
}
