//
//  Pokemon.swift
//  Pokedex
//
//  Created by Damien Bigot on 8/31/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _pokemonUrl: String!
    
    fileprivate var _weight: String!
    fileprivate var _height: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _nextEvolutionTxt: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionLvl: String!
    
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
    
    var weight: String {
        if _weight == nil {
          _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
           _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
  
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: @escaping downloadComplete) {
        let url = URL(string: _pokemonUrl)!
        Alamofire.request(url).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                //print(dict)
                
                if let weight = dict["weight"] as? String {
                  self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                  self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                  self._defense = "\(defense)"
                }
                
                if let attack = dict["attack"] as? Int {
                  self._attack = "\(attack)"
                }
                
//                print(self._weight)
//                print(self._height)
//                print(self._attack)
//                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let type = types[0]["name"] {
                      self._type = type.capitalized
                    }
                    if types.count > 1 {
                        for index in 1...types.count-1 {
                            
                            if let name = types[index]["name"] {
                                self._type.append("/\(name.capitalized)")
                            }
                        }
                    }
                }else {
                  self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        
                        let nsurl = URL(string: "\(BASE_URL)\(url)")!
                        Alamofire.request(nsurl).responseJSON { response in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                    
                                if let desc = descDict["description"] as? String {
                                  self._description = desc
                                }
                            }
                            completed()
                        }
                    }
                }else {
                  self._description = ""
                }
                
                //print(dict["evolutions"]?.count)
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        
                        //Can't support Mega pokemon right now but api still 
                        // has mega data
                        if to.range(of: "mega") == nil {
                        
                            if let str = evolutions[0]["resource_uri"] as? String {
                            
                                let newStr = str.replacingOccurrences(of: "api/v1/pokemon", with: "")
                                let num = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int{

                                    self._nextEvolutionLvl = "\(lvl)"
                                }
                                
//                                print(self._nextEvolutionId)
//                                print(self._nextEvolutionLvl)
//                                print(self._nextEvolutionTxt)
                            }
                        }
                    
                    }
                    
                }
            }
        }
    }
  
}
