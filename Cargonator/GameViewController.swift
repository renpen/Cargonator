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
    
    func gameEnded() {
        initMenuScene()
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
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
            // App must have at least one logged-in user to compose a Tweet
            let composer = TWTRComposerViewController.emptyComposer()
            present(composer, animated: true, completion: nil)
        } else {
            // Log in, and then check again
            TWTRTwitter.sharedInstance().logIn { session, error in
                if session != nil { // Log in succeeded
                    let composer = TWTRComposerViewController.emptyComposer()
                    self.present(composer, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameState.sharedInstance.gameViewController = self
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
