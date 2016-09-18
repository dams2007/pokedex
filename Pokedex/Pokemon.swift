//
//  Pokemon.swift
//  Pokedex
//
//  Created by Damien Bigot on 8/31/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _type: String!
    fileprivate var _defense: String
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvolutionTxt: String!
    
    var name: String {
        get {
            return _name
        }
    }
  
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
  
    init(name: String, pokedexId: Int, type: String, defense: String, height: String, weight: String, attack: String, evolution: String) {
        self._name = name
        self._pokedexId = pokedexId
        self._type = type
        self._defense = defense
        self._height = height
        self._weight = weight
        self._attack = attack
        self._nextEvolutionTxt = evolution
    }
  
}
