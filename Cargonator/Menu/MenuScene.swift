//
//  MenuScene.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 14.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import GameplayKit

class MenuScene: SKScene {
    
    var menuSceneDelegate: NavigationDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode.name == "StartGameLabel" {
                startGame()
            }
        }
    }
    
    func startGame () {
        let sceneSize = self.size
        let startGameTruck = self.childNode(withName: "StartGameTruck")
        let highScoreTruck = self.childNode(withName: "HighScoreTruck")
        let gameTruckEndPoint = CGPoint(x: (startGameTruck?.position.x)! + sceneSize.width, y: (startGameTruck?.position.y)!)
        let highScoreEndPoint = CGPoint(x: (highScoreTruck?.position.x)! + sceneSize.width, y: (highScoreTruck?.position.y)!)
        
        startGameTruck?.run(SKAction.move(to: gameTruckEndPoint, duration: 2))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            highScoreTruck?.run(SKAction.move(to: highScoreEndPoint, duration: 2))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.menuSceneDelegate?.startGame()
        }
    }
}
