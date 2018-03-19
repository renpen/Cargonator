//
//  GameScene.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 23.02.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var movableNode : SKNode?
    var packages = [SKNode]()
    var trucks = [Truck]()
    let packageBitMask: UInt32 = 1 << 0
    let truckBitMask: UInt32 = 1 << 1
    let worldBitMask: UInt32 = 1 << 2
    var touchPosDifferenceX: CGFloat?
    var touchPosDifferenceY: CGFloat?
    
    var playSceneDelegate: NavigationDelegate?

    
    override func sceneDidLoad() {
        GameState.sharedInstance.reset()
        initPlayArea(number: 10, withForce: false)
        initArena()
        initTrucks()
    }
    
    func initArena () {
        
        let footer = self.childNode(withName: "Footer") as! SKSpriteNode
        footer.physicsBody = SKPhysicsBody(rectangleOf: footer.size)
        footer.physicsBody?.categoryBitMask = worldBitMask
        footer.physicsBody?.affectedByGravity = false
        footer.physicsBody?.isDynamic = false
        
        let header = self.childNode(withName: "Header") as! SKSpriteNode
        header.physicsBody = SKPhysicsBody(rectangleOf: header.size)
        header.physicsBody?.categoryBitMask = worldBitMask
        header.physicsBody?.affectedByGravity = false
        header.physicsBody?.isDynamic = false
        
        let cargoZoneTop = self.childNode(withName: "CargoZoneTop") as! SKSpriteNode
        cargoZoneTop.physicsBody = SKPhysicsBody(rectangleOf: cargoZoneTop.size)
        cargoZoneTop.physicsBody?.categoryBitMask = worldBitMask
        cargoZoneTop.physicsBody?.affectedByGravity = false
        cargoZoneTop.physicsBody?.isDynamic = false
        
        let cargoZoneBottom = self.childNode(withName: "CargoZoneBottom") as! SKSpriteNode
        cargoZoneBottom.physicsBody = SKPhysicsBody(rectangleOf: cargoZoneBottom.size)
        cargoZoneBottom.physicsBody?.categoryBitMask = worldBitMask
        cargoZoneBottom.physicsBody?.affectedByGravity = false
        cargoZoneBottom.physicsBody?.isDynamic = false
        
        let rightBorder = self.childNode(withName: "RightBorder") as! SKSpriteNode
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: rightBorder.size)
        rightBorder.physicsBody?.categoryBitMask = worldBitMask
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        
        let leftBorder = self.childNode(withName: "LeftBorder") as! SKSpriteNode
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: leftBorder.size)
        leftBorder.physicsBody?.categoryBitMask = worldBitMask
        leftBorder.physicsBody?.affectedByGravity = false
        leftBorder.physicsBody?.isDynamic = false
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
            truck.physicsBody = SKPhysicsBody(rectangleOf: truck.size)
            truck.physicsBody?.categoryBitMask = truckBitMask
            truck.physicsBody?.isDynamic = false
            truck.physicsBody?.affectedByGravity = false
        }
    }
    
    // MARK: - Drag and Drop
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            print(location)
            
            let touchedNode = self.atPoint(location)
            
            if touchedNode.name == "MenuLabel" {
                playSceneDelegate?.gameEnded()
            } else {
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
                self.movableNode?.physicsBody?.collisionBitMask = packageBitMask | worldBitMask
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            let touchLocation = touch.location(in: self)
            movableNode!.position = CGPoint(x: (touchLocation.x - touchPosDifferenceX!), y: (touchLocation.y - touchPosDifferenceY!))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            

            for truck in self.trucks { // for every truck ...
                if (truck.contains((self.movableNode?.position)!)) { // check if touched package is "above" the truck
                    print("package placed on ", truck.name!)
                    
                    if (truck.checkAcceptance()) { // handover package information from movableNode
                        // package is loaded into truck
                        movableNode?.removeFromParent()
                        print("package ", movableNode!, " delivered")
                        GameState.sharedInstance.packageDelivered()
                    } else {
                        // game lost
                    }
                    // for prototype
                    //initPlayArea(number: 1, withForce: true)
                }
            }
            

        }
        // not released on truck
        self.movableNode?.physicsBody?.collisionBitMask = packageBitMask | worldBitMask | truckBitMask
        movableNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    func addPackageToPlayArea (package: Package) {
        self.addChild(package)
        GameState.sharedInstance.packageSpawned()
    }
    
    func initPlayArea(number: Int, withForce: Bool) {
        let packageArea = self.childNode(withName: "PackageArea")
        let scaleFactor = CGFloat(1.5)
        let packageAreaH = (packageArea?.frame.height)!
        let packageAreaW = (packageArea?.frame.width)!
        for _ in 1...number {
            let package = PackageFactory.sharedInstance.getRandomPackage()
            package.yScale = (packageAreaW / packageAreaH ) * scaleFactor
            package.xScale = scaleFactor
            package.physicsBody?.categoryBitMask = packageBitMask
            package.physicsBody?.collisionBitMask = packageBitMask | truckBitMask | worldBitMask
            package.physicsBody?.isDynamic = true
            package.physicsBody?.affectedByGravity = false
            package.physicsBody?.restitution = 1
            package.physicsBody?.angularDamping = 0.6
            package.physicsBody?.allowsRotation = false
            package.physicsBody?.friction = 0.05
            package.physicsBody?.mass = 0.1
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
            self.addPackageToPlayArea(package: package)
            
            if (withForce) {
                package.physicsBody?.applyImpulse(CGVector(dx: 20.0, dy: 50.0))
            }
        }
    }
}