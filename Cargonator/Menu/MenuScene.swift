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
        let settingsTruck = self.childNode(withName: "SettingsTruck")
        let gameTruckEndPoint = CGPoint(x: sceneSize.width, y: (startGameTruck?.position.y)!)
        let highScoreEndPoint = CGPoint(x: sceneSize.width, y: (highScoreTruck?.position.y)!)
        let settingsEndPoint = CGPoint(x: sceneSize.width, y: (settingsTruck?.position.y)!)
        
        startGameTruck?.run(SKAction.move(to: gameTruckEndPoint, duration: 1.5))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            highScoreTruck?.run(SKAction.move(to: highScoreEndPoint, duration: 1.5))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            settingsTruck?.run(SKAction.move(to: settingsEndPoint, duration: 1.5))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.menuSceneDelegate?.startGame()
        }
    }
}