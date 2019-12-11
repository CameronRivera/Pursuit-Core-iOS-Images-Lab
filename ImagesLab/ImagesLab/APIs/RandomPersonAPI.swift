//
//  RandomPersonAPI.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation
import UIKit

struct RandomPersonAPI: Decodable{
    static func getPeople(from urlString: String, completion: @escaping (Result<[RandomPerson],NetworkError>) -> ()){
        
        NetworkHelper.shared.getData(using: urlString) { results in
            switch results{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do{
                    let results = try JSONDecoder().decode(SearchResults.self, from: data)
                    let people = results.results
                    completion(.success(people))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getProfileImage(from urlString: String, completion: @escaping (Result<UIImage,NetworkError>) -> ()) {
        
        NetworkHelper.shared.getData(using: urlString) { results in
            switch results{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
}
