//
//  RandomPersonTableViewCell.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class RandomPersonTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellNumberLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePicture.image = nil
    }
    
    func setUpCell(using person: RandomPerson){
        RandomPersonAPI.getProfileImage(from: person.picture.thumbnail) { Result in
            switch Result{
            case .failure(let networkError):
                print("Encountered Error: \(networkError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self.profilePicture.image = image
                    self.nameLabel.text = "Name: \(person.name.first) \(person.name.last)"
                    self.ageLabel.text = "Age: \(person.dob.age)"
                    self.cellNumberLabel.text = "Phone Number: \(person.cell)"
                }
            }
        }
    }
    
}
