//
//  ViewController.swift
//  Pokedex
//
//  Created by Damien Bigot on 8/30/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {

  @IBOutlet weak var collectionView :UICollectionView!
  var soundPlayer:AVAudioPlayer!
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  var pokemon = [Pokemon]()
  var filteredPokemon = [Pokemon]()
  var inSearchMode: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    collectionView.delegate = self
    collectionView.dataSource = self
    searchBar.delegate = self
    
    searchBar.returnKeyType = UIReturnKeyType.done
    
    parsePokemonCSV()
    initAudio()
  }
  
  func initAudio() {
    if let soundPlayer = setupAudioPlayerWithFile("music", type: "mp3") {
      soundPlayer.prepareToPlay()
      self.soundPlayer = soundPlayer
      soundPlayer.volume = 0.3
      soundPlayer.play()
    }
  }
  
  func parsePokemonCSV () {
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
    do {
      let csv = try CSV(contentsOfURL: path)
      let rows = csv.rows
      
      for row in rows {
        let pokeId = Int(row["id"]!)!
        let pokeName = row["identifier"]!
        let poke = Pokemon(name: pokeName, pokedexId: pokeId)
        pokemon.append(poke)
      }
      
    } catch let err as NSError {
      print(err.debugDescription)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
      
      let poke:Pokemon
      
      if inSearchMode {
        poke = filteredPokemon[(indexPath as NSIndexPath).row]
      }
      else {
        poke = pokemon[(indexPath as NSIndexPath).row]
      }
      
      
      cell.configureCell(poke)
      
      return cell
      
    } else {
      return UICollectionViewCell()
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if inSearchMode {
      return filteredPokemon.count
    }

    return pokemon.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

    let poke: Pokemon!
    
    if inSearchMode {
      poke = filteredPokemon[(indexPath as NSIndexPath).row]
    } else {
      poke = pokemon[(indexPath as NSIndexPath).row]
    }
    
    performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PokemonDetailVC" {
      if let detailVC = segue.destination as? DetailViewController {
        if let poke = sender as? Pokemon {
          detailVC.pokemon = poke
        }
      }
    }
  }
  
  @IBAction func playMusic(_ sender: UIButton) {
      if soundPlayer.isPlaying {
        soundPlayer.stop()
        sender.alpha = 0.2
      } else {
        soundPlayer.play()
        sender.alpha = 1.0
      }
  }
  
  func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer?  {
    let path = Bundle.main.path(forResource: file as String, ofType: type as String)
    let url = URL(fileURLWithPath: path!)
    
    var audioPlayer:AVAudioPlayer?
    do {
      try audioPlayer = AVAudioPlayer(contentsOf: url)
    } catch {
      print("Player not available")
    }
    return audioPlayer
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      inSearchMode = false
      view.endEditing(true)
      collectionView.reloadData()
    } else {
      inSearchMode = true
      let lower = searchBar.text!.lowercased()
      filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
      collectionView.reloadData()
    }
  }
}

