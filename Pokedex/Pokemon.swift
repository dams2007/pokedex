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
  
  init(name: String, pokedexId: Int) {
    self._name = name
    self._pokedexId = pokedexId
  }
  
}
