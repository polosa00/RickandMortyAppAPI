//
//  File.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import Foundation
import Alamofire


enum Link {
    case urlRickAndMorty
    
    var url: URL {
        switch self {
        case .urlRickAndMorty:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    
    func fetchImage(with url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchRickAndMorty(with url: URL, completion: @escaping(Result<RickAndMorty, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: RickAndMorty.self ) { dataResponse in
                switch dataResponse.result {
                case .success(let rickAndMorty):
                    completion(.success(rickAndMorty))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
    }
    
    
}
