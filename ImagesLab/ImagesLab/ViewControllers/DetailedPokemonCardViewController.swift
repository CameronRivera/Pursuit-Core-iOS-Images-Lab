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
        NetworkHelper.shared.getImage(using: curCard.imageUrlHiRes) { result in
            switch result{
            case .failure(let netError):
                print("Encountered Error: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self.navigationItem.title = curCard.name
                    self.cardImage.image = image
                    self.typeLabel.text = "Type: \(curCard.types.reduce(""){$0 + " " + $1})"
                    self.weaknessLabel.text = "Weaknesses: \(curCard.weaknesses.reduce(""){$0 + " " + $1.type})"
                    self.collectionLabel.text = "Set: \(curCard.set)"
                }
            }
        }
    }

}
