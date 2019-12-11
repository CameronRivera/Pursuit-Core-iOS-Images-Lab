//
//  PokemonViewController.swift
//  ImagesLab
//
//  Created by Cameron Rivera on 12/9/19.
//  Copyright © 2019 Cameron Rivera. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonCards = [PokemonCard](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    var userQuery = ""{
        didSet{
            PokemonCardAPI.getPokemonCards(using: "https://api.pokemontcg.io/v1/cards?name=\(userQuery)") { result in
                switch result{
                case .failure(let netError):
                    print("Encountered Error: \(netError)")
                case .success(let deck):
                    self.pokemonCards = deck
                }
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
}

extension PokemonViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCardTableViewCell else {
            return UITableViewCell()
        }
        
        xCell.cellSetUp(with: pokemonCards[indexPath.row].imageUrlHiRes)
        
        return xCell
    }
}

extension PokemonViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        guard let detailedPokeVC = newStoryboard.instantiateViewController(identifier: "detailedPokeVC") as? DetailedPokemonCardViewController else {
            return
        }
        detailedPokeVC.currentPokemonCard = pokemonCards[indexPath.row]
        navigationController?.pushViewController(detailedPokeVC, animated: true)
    }
}

extension PokemonViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else {
            return
        }
        
        for char in searchText {
            if !char.isLetter{
                return
            }
        }
        
        userQuery = searchText.lowercased()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
