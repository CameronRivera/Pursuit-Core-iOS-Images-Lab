//
//  PokemonCardTableViewCell.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/10/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class PokemonCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    
    private var cellImageURL = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImage.image = nil
    }
    
    func cellSetUp(with urlString: String){
        
        cellImageURL = urlString
        
        NetworkHelper.shared.getImage(using: urlString) { result in
            switch result{
            case .failure(let netError):
                print("netError: \(netError)")
                DispatchQueue.main.async{
                    self.cardImage.image = UIImage(systemName: "circle")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    if self.cellImageURL == urlString {
                        self.cardImage.image = image
                    }
                }
            }
        }
    }
}
