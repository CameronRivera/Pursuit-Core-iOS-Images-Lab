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
    
    func cellSetUp(with card: PokemonCard){
        
        cellImageURL = card.imageUrlHiRes
        
        cardImage.getImage(using: cellImageURL) { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error while setting up pokemon card cell: \(netError)")
                DispatchQueue.main.async{
                    self?.cardImage.image = UIImage(systemName: "circle")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    if self?.cellImageURL == card.imageUrlHiRes {
                        self?.cardImage.image = image
                    }
                }
            }
        }
    }
}
