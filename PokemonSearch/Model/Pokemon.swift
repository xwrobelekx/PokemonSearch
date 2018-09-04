//
//  Pokemon.swift
//  PokemonSearch
//
//  Created by Kamil Wrobel on 9/4/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
    
    let name: String
    let abilities: [AbilitiesDictionary]
    let id: Int
    let image: SpritesDictionary
}


struct AbilitiesDictionary: Decodable {
    let ability: AbilityName
}


struct AbilityName: Decodable {
    let name: String
}


struct SpritesDictionary: Decodable {
    let image: URL
    
    //this enum is for the keys that matches json so we can have a better naming convention
    private enum CodingKeys: String, CodingKey {
        case image = "front_default"
    }
}








let pokemon = Pokemon(name: "Pikachu", abilities: [abilities], id: 25, image: image)

let abilities = AbilitiesDictionary(ability: ability)

let ability = AbilityName(name: "Sleep All Day")

let image = SpritesDictionary(image: URL(string: "htttp://www.lol.com/picture")!)



let pikachuAbilityName = pokemon.abilities[0].ability.name
















