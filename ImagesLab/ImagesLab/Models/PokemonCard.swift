//
//  PokemonCard.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/10/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation

struct Deck: Decodable{
    var cards: [PokemonCard]
}

struct PokemonCard: Decodable{
    var name: String
    var types: [String]?
    var weaknesses: [Weakness]?
    var set: String
    var imageUrl: String
    var imageUrlHiRes: String
}

struct Weakness: Decodable{
    var type: String
    var value: String
}
