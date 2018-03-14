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

class GameViewController: UIViewController, PlaySceneDelegate, MenuSceneDelegate {

    func gameOver() {
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
    
    func initMenuScene () {
        let scene = MenuScene(fileNamed: "MenuScene")
        scene?.scaleMode = .aspectFill
        scene?.menuSceneDelegate = self
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            /*view.showsFPS = true
             view.showsNodeCount = true */
        }
    }
}
