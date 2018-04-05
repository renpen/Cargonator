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
    
    let driveOutAnimationDuration: TimeInterval = 2
    
    override func didMove(to view: SKView) {
        updateCoins()
    }
    
    func updateCoins() {
        if (UserDefaults.standard.value(forKey: "coins") != nil) {
            let label = self.childNode(withName: "CoinLabel") as! SKLabelNode
            label.text = String(UserDefaults.standard.value(forKey: "coins") as! Int)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if touchedNode.name == "StartGameLabel" || touchedNode.name == "StartGameTruck" {
                startGame()
            } else if touchedNode.name == "HighScoreLabel" || touchedNode.name == "HighScoreTruck" {
                menuSceneDelegate?.enterStore()
                updateCoins()
            } else if touchedNode.name == "SettingsLabel" || touchedNode.name == "SettingsTruck"{
                enterSettings()
            }
        }
    }
    
    func driveOutTrucks() {
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
    }
    
    func enterSettings() {
        driveOutTrucks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + driveOutAnimationDuration) {
            self.menuSceneDelegate?.enterSettings()
        }
    }
    
    func startGame() {
        driveOutTrucks()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + driveOutAnimationDuration) {
            self.menuSceneDelegate?.startGame()
        }
    }
}
