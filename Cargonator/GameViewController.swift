//
//  GameViewController.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 23.02.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import TwitterKit

class GameViewController: UIViewController, NavigationDelegate, SocialDelegate {
    
    // - MARK: Navigation Delegate
    
    func gameOver() {
        initEndScore()
    }
    
    func enterMenu() {
        initMenuScene()
    }
    
    func gameEnded() {
        initMenuScene()
    }
    
    func enterStore() {
        
        // FOR prototype plane implementation only!
        let coins = UserDefaults.standard.value(forKey: "coins") as! Int
        
        let costs = 100
        
        if (coins >= costs) {
            // buy plane
            let oldValue = UserDefaults.standard.value(forKey: "planes") as! Int
            print("Old number of planes: ", oldValue)
            
            if (UserDefaults.standard.value(forKey: "planes") == nil) {
                UserDefaults.standard.set(1, forKey: "planes")
            } else {
                let oldValue = UserDefaults.standard.value(forKey: "planes") as! Int
                UserDefaults.standard.set(oldValue + 1, forKey: "planes")
            }
            print("New number of planes: ", UserDefaults.standard.value(forKey: "planes") as! Int)
            // send resourceEvent
            
            GameAnalytics.addResourceEvent(with: GAResourceFlowTypeSink,
               currency: "Coins",
               amount: costs as NSNumber,
               itemType: "Boost",
               itemId: "Plane")
            
            var highScore = 0
            
            if (UserDefaults.standard.value(forKey: "highScore") != nil) {
                highScore = UserDefaults.standard.value(forKey: "highScore") as! Int
            }
            
            let eventString = "HighScoreGadgets:Plane:" + String(highScore)
            
            GameAnalytics.addDesignEvent(withEventId: eventString)
            
            UserDefaults.standard.set(coins-costs, forKey: "coins")
            print("New number of coins: ", UserDefaults.standard.value(forKey: "coins") as! Int)
        } else {
            print("not enough coins: ", coins)
        }
        
    }
    
    func enterSettings() {
        let settingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        settingsViewController.navigationDelegate = self
        self.present(settingsViewController, animated: false, completion: nil)
    }
    
    func startGame() {
        initPlayScene()
    }
    
    // - MARK: Social Delegate
    
    func tweetScore() {
        if (TWTRTwitter.sharedInstance().sessionStore.session() != nil) {
            let composer = TWTRComposer()
            
            let text = "I just scored " + String(GameState.sharedInstance.getScore()) + " points in Cargonator. Join me at cargonator.wordpress.com"
            
            composer.setText(text)
            
            composer.show(from: self, completion: { (result) in
                GameAnalytics.addDesignEvent(withEventId: "Twitter:TweetResult:", value: NSNumber(integerLiteral: GameState.sharedInstance.getScore()))
            })
        } else {
            print("Not logged in")
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameState.sharedInstance.gameViewController = self
        if (UserDefaults.standard.value(forKey: "coins") == nil) {
            UserDefaults.standard.set(400, forKey: "coins")
            print("Added coins: ", 400)
        }
        if (UserDefaults.standard.value(forKey: "planes") == nil) {
            UserDefaults.standard.set(0, forKey: "planes")
            print("Set planes to 0")
        }
        initMenuScene()
    }
    
    func initPlayScene () {
        let scene = PlayScene(fileNamed: "PlayScene")
        scene?.scaleMode = .aspectFill
        scene?.playSceneDelegate = self
        
        if let view = self.view as! SKView? {
            let transition = SKTransition.fade(withDuration: 1)
            transition.pausesOutgoingScene = false
            
            view.presentScene(scene!, transition: transition)
            view.ignoresSiblingOrder = true
            
            /*view.showsFPS = true
             view.showsNodeCount = true */
        }
    }
    
    func initEndScore () {
        let scene = EndScoreScene(fileNamed: "EndScoreScene")
        scene?.scaleMode = .aspectFill
        scene?.gameViewControllerDelegate = self
        scene?.socialDelegate = self
        
        if let view = self.view as! SKView? {
            let transition = SKTransition.fade(withDuration: 1)
            transition.pausesOutgoingScene = false
            
            view.presentScene(scene!, transition: transition)
            view.ignoresSiblingOrder = true
            
            /*view.showsFPS = true
             view.showsNodeCount = true */
        }
    }
    
    func initMenuScene () {
        let scene = MenuScene(fileNamed: "MenuScene")
        scene?.scaleMode = .aspectFill
        scene?.menuSceneDelegate = self
        
        if let view = self.view as! SKView? {
            let transition = SKTransition.fade(withDuration: 1)
            transition.pausesOutgoingScene = false
            
            view.presentScene(scene!, transition: transition)
            
            view.ignoresSiblingOrder = true
            
            /*view.showsFPS = true
             view.showsNodeCount = true */
        }
    }
}
