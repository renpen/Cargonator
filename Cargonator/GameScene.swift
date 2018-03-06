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
        
        
        //circle
        let CGcircle = SKShapeNode(circleOfRadius: 5)
        CGcircle.lineWidth = 1
        CGcircle.strokeColor = UIColor.red
        CGcircle.yScale = packageAreaW / packageAreaH
        CGcircle.fillColor = SKColor.red
        CGcircle.zPosition = 0.1
        packageArea?.addChild(CGcircle)
        CGcircle.position = CGPoint(x: -10.0,y:0.0)
        
        //triangle
        var points = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:5.0,y:5.0),
                      CGPoint(x:10.0,y:0.0),
                      CGPoint(x:0.0,y:0.0)
                      ]
        var triangle = SKShapeNode(points: &points, count: points.count)
        triangle.lineWidth = 1
        triangle.strokeColor = UIColor.green
        triangle.fillColor = UIColor.green
        triangle.zPosition = 0.1
        triangle.setScale(2)
        packageArea?.addChild(triangle)
        triangle.position = CGPoint(x:10, y:-15)
        
        // trapeze
        var pointsT = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:2.5,y:2.5),
                      CGPoint(x:7.5,y:2.5),
                      CGPoint(x:10.0,y:0.0),
                      CGPoint(x:0.0,y:0.0)
        ]
        var trapeze = SKShapeNode(points: &pointsT, count: points.count)
        trapeze.lineWidth = 1
        trapeze.strokeColor = UIColor.blue
        trapeze.fillColor = UIColor.blue
        trapeze.zPosition = 0.1
        packageArea?.addChild(trapeze)
        trapeze.setScale(2)
        trapeze.position = CGPoint(x:-20, y:-15)
    }
}
