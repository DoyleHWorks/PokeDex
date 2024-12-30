//
//  NetworkManager.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager() // Singleton
    private init() {}
    
    func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlString).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


