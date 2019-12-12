//
//  UIImageView+Extensions.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/12/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func getImage(using urlString: String, completion: @escaping (Result<UIImage,NetworkError>) -> ()){
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = center // center of the UIImageView
        addSubview(activityIndicator) // Adds the UIActivityIndicatorView to the UIImageView
        activityIndicator.startAnimating()
        
        NetworkHelper.shared.getData(using: urlString) { [weak activityIndicator] result in
            DispatchQueue.main.async{
                activityIndicator?.stopAnimating()
            }
            
            switch result{
            case .failure(let netError):
                completion(.failure(netError))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
}
