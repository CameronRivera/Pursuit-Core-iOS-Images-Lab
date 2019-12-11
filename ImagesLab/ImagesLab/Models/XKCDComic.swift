//
//  XKCDComic.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/9/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import Foundation
import UIKit

struct XKCDComic: Decodable{
    var num: Int
    var img: String
}

extension XKCDComic{
    
    static func decodeData(using data: Data) -> XKCDComic {
        var comic = XKCDComic(num: 0, img: "")
        
        do{
            comic = try JSONDecoder().decode(XKCDComic.self, from: data)
        } catch{
            print("Encountered Error: \(error)")
        }
        return comic
    }
}
