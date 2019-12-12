//
//  DetailedPokemonCardViewController.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/10/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit


class DetailedPokemonCardViewController: UIViewController {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    var currentPokemonCard: PokemonCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        guard let curCard = currentPokemonCard else {
            return
        }
        
        typeLabel.text = "Type: none"
        weaknessLabel.text = "Weaknesses: none"
        navigationItem.title = curCard.name
        if let typing = curCard.types{
            typeLabel.text = "Type: \(typing.reduce(""){$0 + " " + $1})"
        }
        if let weaks = curCard.weaknesses{
            weaknessLabel.text = "Weaknesses: \(weaks.reduce(""){$0 + " " + $1.type})"
        }
        collectionLabel.text = "Set: \(curCard.set)"
        
        cardImage.getImage(using: curCard.imageUrlHiRes) { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error while getting image: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self?.cardImage.image = image
                }
            }
        }
    }
    
}
