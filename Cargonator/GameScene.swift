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
    let packageBitMask: UInt32 = 0x1 << 0
    
    override func sceneDidLoad() {
        let packageArea = self.childNode(withName: "PackageArea")
        let scaleFactor = CGFloat(1.5)
        let packageAreaH = (packageArea?.frame.height)!
        let packageAreaW = (packageArea?.frame.width)!
        // let CGsquare = SKSpriteNode(color: UIColor.red, size: CGSize(width: 70, height: 70))
        for _ in 1...10 {
            let package = PackageFactory.sharedInstance.getNewPackage()
            package.yScale = (packageAreaW / packageAreaH ) * scaleFactor
            package.xScale = scaleFactor
            package.physicsBody?.categoryBitMask = packageBitMask
            packages.append(package)
            var randomPositionX = Int(arc4random_uniform(300))
            var randomPositionY = Int(arc4random_uniform(300))
            let randomPositionX_Adding = Int(arc4random_uniform(1))
            let randomPositionY_Adding = Int(arc4random_uniform(1))
            if randomPositionX_Adding == 0
            {
                randomPositionX *= -1
            }
            if randomPositionY_Adding == 0
            {
                randomPositionY *= -1
            }
            let randomPos = CGPoint(x: Int(randomPositionX), y: Int(randomPositionY))
            package.position = randomPos
            self.addChild(package)
        }
        
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
