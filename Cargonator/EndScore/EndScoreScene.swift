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
                setHighScore(score: GameState.sharedInstance.getScore())
            } else if touchedNode.name == "TweetButton" {
                self.socialDelegate?.tweetScore()
            }
        }
    }
    
    func setHighScore(score: Int) {
        if (UserDefaults.standard.value(forKey: "highScore") != nil) {
            UserDefaults.standard.set(score, forKey: "onboardingFinished")
        } else {
            if ((UserDefaults.standard.value(forKey: "highScore") as! Int) < score) {
                UserDefaults.standard.set(score, forKey: "onboardingFinished")
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let panel = self.childNode(withName: "Panel")
        let scoreValueLabel = panel?.childNode(withName: "ScoreValueLabel") as! SKLabelNode
        scoreValueLabel.text = String(GameState.sharedInstance.getScore())
    }
}
