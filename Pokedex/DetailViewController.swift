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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var firstEvolutionImage: UIImageView!
    @IBOutlet weak var secondEvolutionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      pokemonName.text = pokemon.name
    }
    @IBAction func dismissDetailViewController(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
