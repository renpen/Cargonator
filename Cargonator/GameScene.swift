//
//  GameScene.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 23.02.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    override func sceneDidLoad() {
        let packageArea = self.childNode(withName: "PackageArea")
        let packageAreaH = (packageArea?.frame.height)! / 1000
        let packageAreaW = (packageArea?.frame.width)! / 1000
        var CGsquare = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10/packageAreaW, height: 10/packageAreaH))
        CGsquare.zPosition = 0.1
        packageArea?.addChild(CGsquare)
        CGsquare.position = CGPoint(x: 10.0, y: 0.0)
        
    }
}
