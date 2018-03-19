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

class GameViewController: UIViewController, NavigationDelegate {

    func gameOver() {
        initEndScore()
    }
    
    func gameEnded() {
        initMenuScene()
    }
    
    func startGame() {
        initPlayScene()
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
