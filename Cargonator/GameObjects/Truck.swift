//
//  Truck.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 07.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import SpriteKit

class Truck: SKSpriteNode {
    var origin_position = CGPoint()
    var truckIdent: TruckIdent? {
        didSet {
            switch truckIdent! {
            case .LeftBottom:
                driveDirection = "left";
            case .LeftTop:
                driveDirection = "left";
            case .RightBottom:
                driveDirection = "right";
            case .RightTop:
                driveDirection = "right";
            }
        }
    }
    var driveDirection: String?
    
    // variables for detecting swipe
    private let minimum_detect_distance: CGFloat = 5
    private var moveAmtX: CGFloat = 0
    private var moveAmtY: CGFloat = 0
    private var initialTouch: CGPoint = CGPoint.zero
    private var initialPosition: CGPoint = CGPoint.zero
    private var truckColor = LevelEngine.sharedInstance.level.randomColor()
    private var truckFigure = LevelEngine.sharedInstance.level.randomFigure()
    private var progressBuffer = ProgressBuffer()
    
    func checkAcceptance (package: Package) -> Bool {
        if package.color == truckColor && truckFigure == package.type {
            progressBuffer.addTime()
            progressBuffer.calcScore(package: package)
            return true
        }
        print("Truck has properties: Figure: " + truckFigure.rawValue + " and " + truckColor.rawValue)
        print("Placed package has properties: Figure: " + package.type.rawValue + " and " + package.color.rawValue)
        return false
    }
    
    // - MARK: Swipe Detection
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            
            if (touch.tapCount > 1) {
                print("Double Tap")
            } else { // swipe
                
                initialTouch = touch.location(in: self.scene!.view)
                moveAmtY = 0
                moveAmtX = 0
                initialPosition = self.position
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first as UITouch! {
            
            let movingPoint: CGPoint = touch.location(in: self.scene!.view)
            
            moveAmtX = movingPoint.x - initialTouch.x
            //moveAmtY = movingPoint.y - initialTouch.y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var swipeDirection = ""
        if (moveAmtX != 0){
            if fabs(moveAmtX) > minimum_detect_distance {
                
                //must be moving side to side
                if moveAmtX < 0 {
                    swipeDirection = "left"
                }
                else {
                    swipeDirection = "right"
                }
                
            }
            
            if (swipeDirection == driveDirection) {
                moveOut()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.driveOutSpeed)) {
                self.moveBack()
            }
            
            //moveAmtY = 0
            moveAmtX = 0
        } else {
            // double tap
        }
        
        
    }
    
    var driveOutSpeed = 3
    var driveInSpeed = 5
    
    func moveOut() {
        let position = self.position
        
        self.origin_position = position
        
        var moveOutAction = SKAction()
        
        if (self.driveDirection == "right") {
            moveOutAction = SKAction.move(to: CGPoint(x: (position.x) + ((size.width) * 1.5),y: (position.y)), duration: TimeInterval(self.driveOutSpeed))
        } else if (self.driveDirection == "left") {
            moveOutAction = SKAction.move(to: CGPoint(x: (position.x) - ((size.width) * 1.5),y: (position.y)), duration: TimeInterval(self.driveOutSpeed))
        }
        
        self.run(moveOutAction)
        
        self.isUserInteractionEnabled = false
    }
    
    func moveBack () {
        progressBuffer = progressBuffer.submit()
        let moveInAction = SKAction.move(to: CGPoint(x: (self.origin_position.x),y: (self.origin_position.y)), duration: TimeInterval(self.driveInSpeed))
        
        self.run(moveInAction)
        
        self.isUserInteractionEnabled = true
        changeAcceptanceState()
    }
    func changeAcceptanceState()
    {
        self.removeAllChildren()
        let package = PackageFactory.sharedInstance.getRandomPackage()
        self.truckColor = package.color
        self.truckFigure = package.type
        // Every different figure has a different starting anchorpoint --> need relocation
//        switch self.truckFigure {
//        case .circle:
//            package.position = CGPoint(x: 50 * xScaler, y: 25 * yScaler)
//            package.xScale = package.xScale * 0.8
//            package.yScale = package.yScale * 0.8
//        case .square:
//            package.position = CGPoint(x: 25 * xScaler, y: 1 * yScaler)
//        case .trapeze:
//            package.position = CGPoint(x: -90 * xScaler, y: 1 * yScaler)
//        case .triangle:
//            package.position = CGPoint(x: -90 * xScaler, y: 1 * yScaler)
//        }
        doFormReposition(package: package)
        package.physicsBody = nil
        self.addChild(package)
    }
    
    // ToDo: Refactoring neccesarry. very high coupling here
    func doFormReposition(package : Package) {
        var xScaler =  1 / self.xScale
        var yScaler = 1 / self.yScale
        package.xScale = xScaler
        package.yScale = yScaler
        switch truckIdent! {
        case .LeftBottom:
            switch self.truckFigure {
            case .trapeze:
                package.position =  CGPoint(x: -1 * xScaler, y: 1 * yScaler)
            case .triangle:
                package.position =  CGPoint(x: -1 * xScaler, y: 1 * yScaler)
            case .circle:
                package.position = CGPoint(x: 40 * xScaler, y: 25 * yScaler)
                package.xScale = package.xScale * 0.8
                package.yScale = package.yScale * 0.8
            case .square:
                package.position = CGPoint(x: 25 * xScaler, y: 1 * yScaler)
            }
        case .LeftTop:
            switch self.truckFigure {
            case .trapeze:
                package.position =  CGPoint(x: -1 * xScaler, y: 1 * yScaler)
            case .triangle:
                package.position =  CGPoint(x: -1 * xScaler, y: 1 * yScaler)
            case .circle:
                package.position = CGPoint(x: 40 * xScaler, y: 25 * yScaler)
                package.xScale = package.xScale * 0.8
                package.yScale = package.yScale * 0.8
            case .square:
                package.position = CGPoint(x: 25 * xScaler, y: 1 * yScaler)
            }
        case .RightTop:
            switch self.truckFigure {
            case .trapeze:
                package.position =  CGPoint(x: -90 * xScaler, y: -1 * yScaler)
            case .triangle:
                package.position =  CGPoint(x: -90 * xScaler, y: -1 * yScaler)
            case .circle:
                package.position = CGPoint(x: -40 * xScaler, y: +25 * yScaler)
                package.xScale = package.xScale * 0.8
                package.yScale = package.yScale * 0.8
            case .square:
                package.position = CGPoint(x: -65 * xScaler, y: -1 * yScaler)
            }
        case .RightBottom:
            switch self.truckFigure {
            case .trapeze:
                package.position =  CGPoint(x: -90 * xScaler, y: -1 * yScaler)
            case .triangle:
                package.position =  CGPoint(x: -90 * xScaler, y: -1 * yScaler)
            case .circle:
                package.position = CGPoint(x: -40 * xScaler, y: +25 * yScaler)
                package.xScale = package.xScale * 0.8
                package.yScale = package.yScale * 0.8
            case .square:
                package.position = CGPoint(x: -65 * xScaler, y: -1 * yScaler)
            }
        }
        
    }
    
}
