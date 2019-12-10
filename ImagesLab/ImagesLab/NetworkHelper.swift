//
//  NetworkHelper.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/9/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation

class NetworkHelper{
    private var session: URLSession
    static let shared = NetworkHelper()
    
    init(){
        session = URLSession.init(configuration: .default)
    }
    
    func getData(using urlString: String, completion: @escaping (Result<Data, NetworkError>) -> ()) {
        
        guard let fileURL = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let dataTask = session.dataTask(with: fileURL) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            guard let data = data else{
                completion(.failure(.noData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            switch httpResponse.statusCode{
            case 200...299:
                break
            default:
                completion(.failure(.badStatusCode(httpResponse.statusCode)))
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
}
