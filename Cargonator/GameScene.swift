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
    var movableNode : SKNode?
    var packages = [SKNode]()
    var trucks = [Truck]()
    
    override func sceneDidLoad() {
        let packageArea = self.childNode(withName: "PackageArea")
        let packageAreaH = (packageArea?.frame.height)! / 1000
        let packageAreaW = (packageArea?.frame.width)! / 1000
        let CGsquare = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10/packageAreaW, height: 10/packageAreaH))
        CGsquare.zPosition = 0.3
        self.addChild(CGsquare)
        CGsquare.position = CGPoint(x: 10.0, y: 0.0)
        
        packages.append(CGsquare)
        
        //circle
        let CGcircle = SKShapeNode(circleOfRadius: 5)
        CGcircle.lineWidth = 1
        CGcircle.strokeColor = UIColor.red
        CGcircle.yScale = packageAreaW / packageAreaH
        CGcircle.fillColor = SKColor.red
        CGcircle.zPosition = 0.3
        self.addChild(CGcircle)
        CGcircle.position = CGPoint(x: -10.0,y:0.0)
        
        packages.append(CGcircle)
        
        //triangle
        //points need to be that high to improve edges. combined with setScale
        var points = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:50.0,y:50.0),
                      CGPoint(x:100.0,y:0.0),
                      CGPoint(x:0.0,y:0.0)
                      ]
        let triangle = SKShapeNode(points: &points, count: points.count)
        triangle.lineWidth = 1
        triangle.strokeColor = UIColor.green
        triangle.fillColor = UIColor.green
        triangle.zPosition = 0.3
        triangle.setScale(0.2)
        //packageArea?.addChild(triangle)
        self.addChild(triangle)
        triangle.position = CGPoint(x:10, y:-15)
        
        packages.append(triangle)
        
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
        trapeze.zPosition = 0.3
        self.addChild(trapeze)
        trapeze.setScale(0.2)
        trapeze.position = CGPoint(x:-20, y:-15)
        
        packages.append(trapeze)
        
        initTrucks()
    }
    
    // MARK: - Trucks
    
    func initTrucks () {
        
        self.trucks = [Truck]()
        
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
    
    // MARK: - Drag and Drop
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            print(location)
            for package in packages {
                if package.contains(location) {
                    movableNode = package
                    movableNode!.position = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            let touchLocation = touch.location(in: self)
            
            if (self.childNode(withName: "PackageArea")?.contains(touchLocation))! {
                print("in")
                movableNode!.position = touch.location(in: self)
            } else {
                for truck in self.trucks {
                    if (truck.contains(touchLocation)) { // truck contains package
                        movableNode!.position = touch.location(in: self)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            let touchLocation = touch.location(in: self)

            if (self.childNode(withName: "PackageArea")?.contains(touchLocation))! {
                movableNode!.position = touch.location(in: self)
            } else {
                for truck in self.trucks {
                    if (truck.contains(touchLocation)) { // truck contains package
                        print("package placed on ", truck.name!)
                        movableNode!.position = touch.location(in: self)
                        // destroy package here
                        
                        if (truck.checkAcceptance()) { // handover package information from movableNode
                            movableNode?.removeFromParent()
                            print("package ", movableNode!, " delivered")
                        } else {
                            // game lost
                        }
                    }
                }
            }
            movableNode = nil
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
}
