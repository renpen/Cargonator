//
//  EndScoreScene.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import SpriteKit

class EndScoreScene: SKScene {
    
    var gameViewControllerDelegate: NavigationDelegate?
    var socialDelegate: SocialDelegate?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode.name == "MenuButton" || touchedNode.name == "MenuLabel"{
                self.gameViewControllerDelegate?.enterMenu()
                
            } else if touchedNode.name == "TweetButton" {
                self.socialDelegate?.tweetScore()
            }
        }
    }
    
    func addCoins(newCoins: Int) {
        GameAnalytics.addResourceEvent(with: GAResourceFlowTypeSource, currency: "Coins", amount: newCoins as NSNumber, itemType: nil, itemId: "LevelEnd")
        print(newCoins)
        if (UserDefaults.standard.value(forKey: "coins") == nil) {
            UserDefaults.standard.set(newCoins, forKey: "coins")
        } else {
            let oldValue = UserDefaults.standard.value(forKey: "coins") as! Int
            UserDefaults.standard.set(oldValue + newCoins, forKey: "coins")
        }
        print(UserDefaults.standard.value(forKey: "coins") as! Int)
    }
    
    func setHighScore(score: Int) {
        print("saving highscore: ", score)
        if (UserDefaults.standard.value(forKey: "highScore") == nil) {
            print("first highscore save")
            UserDefaults.standard.set(score, forKey: "highScore")
        } else {
            if ((UserDefaults.standard.value(forKey: "highScore") as! Int) < score) {
                print("overriding highscore")
                UserDefaults.standard.set(score, forKey: "highScore")
            } else {
                print("no highscore saved")
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let panel = self.childNode(withName: "Panel")
        let scoreValueLabel = panel?.childNode(withName: "ScoreValueLabel") as! SKLabelNode
        let coinsValueLabel = panel?.childNode(withName: "CoinsValueLabel") as! SKLabelNode
        
        // save highscore
        setHighScore(score: GameState.sharedInstance.getScore())
        
        // calc coins
        let round_coins = GameState.sharedInstance.getCoins()
        
        // save coins
        addCoins(newCoins: round_coins)
        
        scoreValueLabel.text = String(GameState.sharedInstance.getScore())
        coinsValueLabel.text = String(GameState.sharedInstance.getCoins())
        
    }
}
