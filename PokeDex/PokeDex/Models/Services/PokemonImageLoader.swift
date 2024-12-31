//
//  PokemonImageLoader.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import UIKit
import Kingfisher

final class PokemonImageLoader {
    static func loadImage(from url: String, into imageView: UIImageView) {
        guard let imageURL = URL(string: url) else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
        
        DispatchQueue.main.async {
            imageView.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        }
    }
}
