//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Damien Bigot on 9/11/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  var pokemon: Pokemon!
  
  @IBOutlet weak var pokemonName: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      pokemonName.text = pokemon.name

        // Do any additional setup after loading the view.
    }
}
