//
//  PokemonSearchViewController.swift
//  PokemonSearch
//
//  Created by Kamil Wrobel on 9/4/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UISearchBarDelegate{
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let pokemonText = searchBar.text else {return}
        
        PokemonController.shared.fetchPokemon(by: pokemonText) { (pokemon) in
            guard let unwrappedPokemon = pokemon else {self.presentAlert(); return}
            DispatchQueue.main.async {
                
                self.nameLabel.text = unwrappedPokemon.name
                self.idLabel.text = "\(String(describing: unwrappedPokemon.id))"
                self.abilitiesLabel.text = "Abilities: \(unwrappedPokemon.abilitiesName.joined(separator: ", "))"
            }
            PokemonController.shared.fetchImage(pokemon: unwrappedPokemon, completion: { (image) in
                guard let unwrappedImage = image else {
                    DispatchQueue.main.async {
                        self.presentAlert()
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.pokemonImageView.image = unwrappedImage
                }
            })
        }
        //dismiss keyboard
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    func presentAlert() {
        let alert = UIAlertController(title: "WRONG  POKEMON NAME", message: " 🤬🤬🤬🤬  ...or it doesnt have an image 😪 ", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true)
        
    }
    
    
    

}
