//
//  RandomPeron.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation

struct SearchResults: Decodable{
    var results: [RandomPerson]
}

struct RandomPerson: Decodable{
    var name: Name
    var dob: Age
    var cell: String
    var phone: String
    var picture: ProfileImage
    var location: Location
}

struct Name: Decodable{
    var title: String
    var first: String
    var last: String
}

struct Age: Decodable{
    var date: String
    var age: Int
}

struct ProfileImage: Decodable{
    var large: String
    var thumbnail: String
}

struct Location: Decodable{
    var street: Street
    var city: String
    var state: String
    var country: String
}

struct Street: Decodable{
    var number: Int
    var name: String
}
