//
//  ViewController.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/9/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class XKCDComicViewController: UIViewController {
    
    @IBOutlet weak var comicView: UIImageView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var recentButton: UIBarButtonItem!
    @IBOutlet weak var randomButton: UIButton!
    
    var issueNumber = Int()
    var maxIssueNumber = Int()
    var firstLoad = false
    
    var comicImage = UIImage(){
        didSet{
            DispatchQueue.main.async{
                self.comicView.image = self.comicImage
            }
        }
    }
    
    var data = Data() {
        didSet{
            currentlyShowingComic = XKCDComic.decodeData(using: data)
        }
    }
    
    var currentlyShowingComic = XKCDComic(num: 0, img: ""){
        didSet{
            if !firstLoad{
                maxIssueNumber = currentlyShowingComic.num
                DispatchQueue.main.async{
                    self.stepper.maximumValue = Double(self.maxIssueNumber)
                }
                firstLoad = true
            }
            DispatchQueue.main.async{
                self.stepper.value = Double(self.currentlyShowingComic.num)
            }
            NetworkHelper.shared.getData(using: currentlyShowingComic.img) { (result) in
                switch result{
                case .failure(let netError):
                    print(netError)
                case .success(let data):
                    if let image = UIImage(data: data){
                        self.comicImage = image
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        stepper.minimumValue = 0.0
        stepper.stepValue = 1.0
        textField.placeholder = "Enter an issue number"
        textField.delegate = self
        recentButton.title = "Current Issue"
        randomButton.setTitle("Random Issue", for: .normal)
    }
    
    private func setUp(){
        NetworkHelper.shared.getData(using: "http://xkcd.com/info.0.json") { (result) in
            switch result{
            case .failure(let netError):
                print(netError)
            case .success(let data):
                self.data = data
            }
        }
    }
    
    @IBAction func mostRecentButtonPressed(_ sender: UIBarButtonItem){
        NetworkHelper.shared.getData(using: "http://xkcd.com/info.0.json") { (result) in
            switch result{
            case .failure(let netError):
                print(netError)
            case .success(let data):
                self.data = data
            }
        }
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        issueNumber = Int.random(in: 0...maxIssueNumber)
        
        NetworkHelper.shared.getData(using: "https://xkcd.com/\(issueNumber)/info.0.json") {
            results in
            switch results{
            case .failure(let netError):
                print(netError)
            case .success(let data):
                self.data = data
            }
        }
    }
    
    @IBAction func stepperStepped(_ sender: UIStepper){
        NetworkHelper.shared.getData(using: "https://xkcd.com/\(Int(stepper.value))/info.0.json") { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                self.data = data
            }
        }
    }
    
}

extension XKCDComicViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        for char in text{
            if !char.isNumber{
                return false
            }
        }
        
        issueNumber = Int(text) ?? maxIssueNumber
        
        if issueNumber > maxIssueNumber{
            return false
        }
        
        NetworkHelper.shared.getData(using: "https://xkcd.com/\(issueNumber)/info.0.json") {
            results in
            switch results{
            case .failure(let netError):
                print(netError)
            case .success(let data):
                self.data = data
            }
        }
        
        textField.resignFirstResponder()
        return true
    }
}

