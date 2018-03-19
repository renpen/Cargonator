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
                self.gameViewControllerDelegate?.gameEnded()
            } else if touchedNode.name == "TweetButton" {
                self.socialDelegate?.tweetScore()
            }
        }
    }
}
