//
//  ViewController.swift
//  Pokedex
//
//  Created by Damien Bigot on 8/30/16.
//  Copyright © 2016 Damien Bigot. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

  @IBOutlet weak var collectionView :UICollectionView!
  var soundPlayer:AVAudioPlayer!
  
  
  var pokemon = [Pokemon]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
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
    let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
    
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
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
      
      let poke = pokemon[indexPath.row]
      
      cell.configureCell(poke)
      
      return cell
      
    } else {
      return UICollectionViewCell()
    }
    
  }

  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 718
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(105, 105)
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
    
  }
  
  @IBAction func playMusic(sender: UIButton) {
      if soundPlayer.playing {
        soundPlayer.stop()
        sender.alpha = 0.2
      } else {
        soundPlayer.play()
        sender.alpha = 1.0
      }
  }
  
  func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
    let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
    let url = NSURL.fileURLWithPath(path!)
    
    var audioPlayer:AVAudioPlayer?
    do {
      try audioPlayer = AVAudioPlayer(contentsOfURL: url)
    } catch {
      print("Player not available")
    }
    return audioPlayer
  }
}

