//
//  GameViewController.swift
//  CookieCrunch
//
//  Created by Razeware on 13/04/16.
//  Copyright (c) 2016 Razeware LLC. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
  
    // MARK: Properties
    
    // The scene draws the tiles and cookie sprites, and handles swipes.
    var scene: GameScene!
    
    var movesLeft = 0
    var score = 0
    
    lazy var backgroundMusic: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource: "Mining by Moonlight", withExtension: "mp3") else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    // MARK: IBOutlets
    @IBOutlet weak var gameOverPanel: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
  
  // The level contains the tiles, the cookies, and most of the gameplay logic.
  // Needs to be ! because it's not set in init() but in viewDidLoad().
  var level: Level!
  
  
  // MARK: View Controller Functions
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return [.portrait, .portraitUpsideDown]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure the view.
    let skView = view as! SKView
    skView.isMultipleTouchEnabled = false
    
    // Create and configure the scene.
    scene = GameScene(size: skView.bounds.size)
    scene.scaleMode = .aspectFill
    
    // Load the level.
    level = Level(filename: "Level_0")
    scene.level = level
    
    scene.addTiles()
    
    // Present the scene.
    skView.presentScene(scene)
    
    // Start the game.
    beginGame()
  }
  
  
  // MARK: Game functions
  
  func beginGame() {
    shuffle()
  }
  
  func shuffle() {
    // Fill up the level with new cookies, and create sprites for them.
    let newCookies = level.shuffle()
    scene.addSprites(for: newCookies)
  }
  
}
