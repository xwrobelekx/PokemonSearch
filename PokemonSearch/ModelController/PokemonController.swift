//
//  PokemonController.swift
//  PokemonSearch
//
//  Created by Kamil Wrobel on 9/4/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit


class PokemonController {
    
    static let shared = PokemonController()
    
    // This makes it so we cant make another instanc of PokemonController out of this class
    private init() {}
    
    //#3 we need base url - components are smart enough to figure where to ad slashes
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    
    
    //#1 know what you want to display (complete)to the user
    //Whenever you see the @escaping that means that the function (closure) will escape out of the function and complete at a later time.
    //Gives you the ability to create 2 paths when you call it
    func fetchPokemon(by pokemonName: String, completion: @escaping (Pokemon?) -> Void) {
        
        guard let unwrappedBaseUrl = baseURL else {
            fatalError("🛑Error bad base url")
        }
        //components not needed bc we dont have any querry items
        //var components = URLComponents(url: unwrappedBaseUrl, resolvingAgainstBaseURL: true)
        
        let requestURL = unwrappedBaseUrl.appendingPathComponent("pokemon").appendingPathComponent(pokemonName)
        
        
        //#4Build your url - Components ("/"), Querys [:], and Extension (".")
        
        //#2 Call URLSesion - so you can work backwards
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            //#3 Do try catch
            do {
                //#1 Handle your error
                if let error = error { throw error }
                
                //#2 Handle data
                guard let data = data else { throw NSError() }
                
                //#4 JSONDecoder
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
                
                
            }catch let error {
                print("🛑Error fetching pokemon \(error), \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //#5 Decode & Complete your object
        
        }.resume()
        
    }
    
    func fetchImage(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void){
        
        let imageUrl = pokemon.spritesDictionary.image
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            
            do {
                if let error = error {throw error}
                guard let data = data else {throw NSError() }
                
                //completion nil means tha it wont return enything. As soon as it sees the key word return, it will just return
                guard let image =  UIImage(data: data) else {completion(nil); return}
                completion(image)
                print("🚆are you on the main thread: \(Thread.isMainThread)")
            
            }catch let error {
                print("🛑Error fetching image \(error), \(error.localizedDescription)")
                completion(nil)
                return
            }
            
        }.resume()
    }
}
