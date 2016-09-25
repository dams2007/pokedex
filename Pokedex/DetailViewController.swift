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
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
        firstEvolutionImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails {
            // this will be called after download is done
            self.updateUI()
        }
    }
    
    func updateUI() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        idLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No Evolutions"
            secondEvolutionImage.isHidden = true
        } else {
            secondEvolutionImage.isHidden = false
            print(pokemon.nextEvolutionId)
            secondEvolutionImage.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            evolutionLabel.text = str
        }
        
    }
    
    @IBAction func dismissDetailViewController(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
