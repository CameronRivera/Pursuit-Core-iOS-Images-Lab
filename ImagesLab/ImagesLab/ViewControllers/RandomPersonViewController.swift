//
//  RandomPersonViewController.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/11/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class RandomPersonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [RandomPerson](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUp(){
        RandomPersonAPI.getPeople(from: "https://randomuser.me/api/?results=50") { [weak self] result in
            switch result{
            case .failure(let netError):
                print("Encountered Error: \(netError)")
            case .success(let persons):
                self?.people = persons
            }
        }
    }

}

extension RandomPersonViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? RandomPersonTableViewCell else {
            return UITableViewCell()
        }
        
        xCell.setUpCell(using: people[indexPath.row])
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
}

extension RandomPersonViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedPersonVC = newStoryboard.instantiateViewController(identifier: "detailedHumanVC") as? DetailedPersonViewController else {
            return
        }
        detailedPersonVC.currentHuman = people[indexPath.row]
        navigationController?.pushViewController(detailedPersonVC, animated: true)
    }
}
