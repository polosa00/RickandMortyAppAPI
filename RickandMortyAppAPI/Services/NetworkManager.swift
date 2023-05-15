//
//  File.swift
//  RickandMortyAppAPI
//
//  Created by Александр Полочанин on 15.05.23.
//

import Foundation


enum Link {
    case urlRickAndMorty
    
    var url: URL {
        switch self {
        case .urlRickAndMorty:
            return URL(string: "https://rickandmortyapi.com/api/character")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
    case invalidURL
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    
    func fetchRickAndMortyData(with url: URL?, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
        guard let url = url else {
            print(NetworkError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let rickAndMorty = try decoder.decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(rickAndMorty))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    func fetchImage(with url: URL, completion: @escaping (Data) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    
}
