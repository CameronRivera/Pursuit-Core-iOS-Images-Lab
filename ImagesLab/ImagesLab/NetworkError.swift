//
//  NetworkError.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/9/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case badURL(String) // Associated Value
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int) // 404, 500
    case badMimeType(String) // image / jpeg}
}
