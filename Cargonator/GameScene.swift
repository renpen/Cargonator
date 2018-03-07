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
        //points need to be that high to improve edges. combined with setScale
        var points = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:50.0,y:50.0),
                      CGPoint(x:100.0,y:0.0),
                      CGPoint(x:0.0,y:0.0)
                      ]
        var triangle = SKShapeNode(points: &points, count: points.count)
        triangle.lineWidth = 1
        triangle.strokeColor = UIColor.green
        triangle.fillColor = UIColor.green
        triangle.zPosition = 0.1
        triangle.setScale(0.2)
        packageArea?.addChild(triangle)
        triangle.position = CGPoint(x:10, y:-15)
        
        // trapeze
        //points need to be that high to improve edges. combined with setScale
        var pointsT = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:25,y:25),
                      CGPoint(x:75,y:25),
                      CGPoint(x:100,y:0.0),
                      CGPoint(x:0.0,y:0.0)
        ]
        let trapeze = SKShapeNode(points: &pointsT, count: points.count)
        trapeze.lineWidth = 1
        trapeze.strokeColor = UIColor.blue
        trapeze.fillColor = UIColor.blue
        trapeze.zPosition = 0.1
        packageArea?.addChild(trapeze)
        trapeze.setScale(0.2)
        trapeze.position = CGPoint(x:-20, y:-15)
        
        initTrucks()
    }
    
    func initTrucks () {
        
        var trucks = [Truck]()
        
        let truckRightTop = self.childNode(withName: "TruckRightTop") as! Truck
        let truckRightBottom = self.childNode(withName: "TruckRightBottom") as! Truck
        let truckLeftTop = self.childNode(withName: "TruckLeftTop") as! Truck
        let truckLeftBottom = self.childNode(withName: "TruckLeftBottom") as! Truck
        
        truckRightTop.driveDirection = "right"
        trucks.append(truckRightTop)
        
        truckRightBottom.driveDirection = "right"
        trucks.append(truckRightBottom)
        
        truckLeftTop.driveDirection = "left"
        trucks.append(truckLeftTop)
        
        truckLeftBottom.driveDirection = "left"
        trucks.append(truckLeftBottom)
        
        for truck in trucks {
            truck.isUserInteractionEnabled = true
        }
    }
}
