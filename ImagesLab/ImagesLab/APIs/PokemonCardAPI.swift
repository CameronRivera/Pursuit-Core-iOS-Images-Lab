//
//  PokemonCardAPI.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/10/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation

struct PokemonCardAPI{
    static func getPokemonCards(using urlString: String, completion: @escaping (Result<[PokemonCard],NetworkError>) -> ()){
        
        NetworkHelper.shared.getData(using: urlString) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(netError))
            case .success(let data):
                do{
                    let pokeDeck = try JSONDecoder().decode(Deck.self, from: data)
                    completion(.success(pokeDeck.cards))
                    
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
