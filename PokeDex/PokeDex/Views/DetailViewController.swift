//
//  DetailViewController.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class DetailViewController: UIViewController {
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    
    private let pokemonContainerView = UIView().then {
        $0.backgroundColor = .pdRedDark
        $0.layer.cornerRadius = 15
    }
    
    private let pokemonImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let pokemonNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.textColor = .white
    }
    
    private let pokemonInfoLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    var pokemonID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        if let id = pokemonID {
            viewModel.fetchDetail(id: id)
        }
    }

    private func setupUI() {
        view.backgroundColor = .pdRedMain
        view.addSubview(pokemonContainerView)
        pokemonContainerView.addSubview(pokemonImageView)
        pokemonContainerView.addSubview(pokemonNameLabel)
        pokemonContainerView.addSubview(pokemonInfoLabel)
        
        pokemonContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        pokemonImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        pokemonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        pokemonInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func bindViewModel() {
        viewModel.pokemonDetail
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] detail in
                guard let self = self else { return }
                
                let imageUrl = APIEndpoints.mainViewImage(id: detail.id)
                DispatchQueue.main.async {
                    PokemonImageLoader.loadImage(from:imageUrl, into: self.pokemonImageView)
                }
                
                self.pokemonNameLabel.text = "No.\(detail.id)  \(detail.name.capitalized)"
                
                let types = detail.types.map { $0.type.name.capitalized }.joined(separator: ", ")
                let typeText = "Types: \(types)"
                let heightInMeters = Double(detail.height) / 10.0
                let weightInKilograms = Double(detail.weight) / 10.0
                let heightText = String(format: "Height: %.1f m", heightInMeters)
                let weightText = String(format: "Weight: %.1f kg", weightInKilograms)
                let infoText = "\(typeText)\n\(heightText)\n\(weightText)"
                self.pokemonInfoLabel.text = infoText
            })
            .disposed(by: disposeBag)
        
        // Handle errors
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

