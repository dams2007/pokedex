//
//  PokeCell.swift
//  Pokedex
//
//  Created by Damien Bigot on 9/2/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
  
  @IBOutlet weak var thumbImg: UIImageView!
  @IBOutlet weak var labelName: UILabel!
  
  var pokemon: Pokemon!
  
  func configureCell(pokemon: Pokemon) {
    
    self.pokemon = pokemon
    thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    labelName.text = pokemon.name.capitalizedString
  }
    
}
