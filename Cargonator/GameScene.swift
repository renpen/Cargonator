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
    var touchPosDifferenceX: CGFloat?
    var touchPosDifferenceY: CGFloat?
    
    
    override func sceneDidLoad() {
        initPlayArea(number: 10)
        initTrucks()
    }
    
    // MARK: - Trucks
    
    func initTrucks () {
        
        self.trucks = [Truck]()
        
        let truckRightTop = self.childNode(withName: "TruckRightTop") as! Truck
        let truckRightBottom = self.childNode(withName: "TruckRightBottom") as! Truck
        let truckLeftTop = self.childNode(withName: "TruckLeftTop") as! Truck
        let truckLeftBottom = self.childNode(withName: "TruckLeftBottom") as! Truck
        
        /*var texture = PackageFactory.sharedInstance.getSpecificPackage(fig: Figure.circle)
        texture.setScale(300)
        truckLeftTop.addChild(texture)
        texture.position = CGPoint(x: 10000, y: 7000)
        
        var texture1 = PackageFactory.sharedInstance.getSpecificPackage(fig: Figure.triangle)
        texture1.setScale(200)
        truckRightTop.addChild(texture1)
        texture1.position = CGPoint(x: -20000, y: 1000)*/
        
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
                    self.movableNode = package
                    if let node = self.movableNode {
                        self.touchPosDifferenceX = location.x - node.position.x
                        self.touchPosDifferenceY = location.y - node.position.y
                    }
                    //movableNode!.position = location
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            let touchLocation = touch.location(in: self)
            
            if (self.childNode(withName: "PackageArea")?.contains(touchLocation))! {
                print("in")
                movableNode!.position = CGPoint(x: (touchLocation.x - touchPosDifferenceX!), y: (touchLocation.y - touchPosDifferenceY!))
            } else {
                for truck in self.trucks {
                    if (truck.contains(touchLocation)) { // truck contains package
                        movableNode!.position = CGPoint(x: (touchLocation.x - touchPosDifferenceX!), y: (touchLocation.y - touchPosDifferenceY!))
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            let touchLocation = touch.location(in: self)
            if (self.childNode(withName: "PackageArea")?.contains(touchLocation))! {
                //movableNode!.position = touchLocation
            } else {
                for truck in self.trucks {
                    if (truck.contains((self.movableNode?.position)!)) { // truck contains package
                        print("package placed on ", truck.name!)
                        // movableNode!.position = touchLocation
                        // destroy package here
                        
                        if (truck.checkAcceptance()) { // handover package information from movableNode
                            movableNode?.removeFromParent()
                            print("package ", movableNode!, " delivered")
                        } else {
                            // game lost
                        }
                        initPlayArea(number: 1)
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
    func initPlayArea(number: Int) {
        let packageArea = self.childNode(withName: "PackageArea")
        let scaleFactor = CGFloat(1.5)
        let packageAreaH = (packageArea?.frame.height)!
        let packageAreaW = (packageArea?.frame.width)!
        // let CGsquare = SKSpriteNode(color: UIColor.red, size: CGSize(width: 70, height: 70))
        for _ in 1...number {
            let package = PackageFactory.sharedInstance.getRandomPackage()
            package.yScale = (packageAreaW / packageAreaH ) * scaleFactor
            package.xScale = scaleFactor
            package.physicsBody?.categoryBitMask = packageBitMask
            packages.append(package)
            var randomPositionX = Int(arc4random_uniform(300))
            var randomPositionY = Int(arc4random_uniform(300))
            let randomPositionX_Adding = Int(arc4random_uniform(2))
            let randomPositionY_Adding = Int(arc4random_uniform(2))
            if randomPositionX_Adding == 0
            {
                randomPositionX *= -1
            }
            if randomPositionY_Adding == 0
            {
                randomPositionY *= -1
            }
            print("Position: ", randomPositionX)
            let randomPos = CGPoint(x: Int(randomPositionX), y: Int(randomPositionY))
            package.position = randomPos
            self.addChild(package)
        }
    }
}
