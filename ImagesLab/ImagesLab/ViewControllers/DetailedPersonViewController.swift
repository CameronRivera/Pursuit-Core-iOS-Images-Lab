//
//  DetailedPersonViewController.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailedPersonViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellNumberLabel: UILabel!
    @IBOutlet weak var homePhoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentHuman: RandomPerson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp(){
        guard let human = currentHuman else {
            return
        }
        
        imageView.getImage(using: human.picture.large) { [weak self] Result in
            switch Result{
            case .failure(let netError):
                print("Encountered Error: \(netError)")
            case .success(let image):
                DispatchQueue.main.async{
                    self?.imageView.image = image
                    self?.nameLabel.text = "Name: \(human.name.first) \(human.name.last)"
                    self?.ageLabel.text = "Age: \(human.dob.age)"
                    self?.cellNumberLabel.text = "Cell Number: \(human.cell)"
                    self?.homePhoneLabel.text = "Home Number: \(human.phone)"
                    self?.locationLabel.text = "Address: \(human.location.street.number) \(human.location.street.name), \(human.location.city) \(human.location.state), \(human.location.country)"
                }
            }
        }
    }

}
