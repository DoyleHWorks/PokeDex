//
//  NetworkManager.swift
//  PokeDex
//
//  Created by t0000-m0112 on 2024-12-30.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager() // Singleton
    private init() {}
    
    func fetch<T: Decodable>(urlString: String) -> Single<T> {
        return Single.create { single in
            guard let url = URL(string: urlString) else {
                single(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }
            
            let request = AF.request(url)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let decodedData):
                        single(.success(decodedData))
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            single(.failure(NetworkError.serverError(statusCode: statusCode)))
                        } else if (response.data ?? Data()).isEmpty {
                            single(.failure(NetworkError.noData))
                        } else {
                            single(.failure(NetworkError.unknown(error)))
                        }
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }
}


