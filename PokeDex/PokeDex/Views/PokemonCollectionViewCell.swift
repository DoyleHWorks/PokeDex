//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import UIKit
import SnapKit
import Then

final class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.lineBreakMode = .byWordWrapping
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .pdCellBackground
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(contentView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(with item: PokemonListItem) {
        nameLabel.text = item.name.capitalized
        if let id = item.id {
            let imageUrl = APIEndpoints.mainViewImage(id: id)
            DispatchQueue.main.async {
                PokemonImageLoader.loadImage(from: imageUrl, into: self.imageView)
            }
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
