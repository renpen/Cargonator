//
//  AnimationPlane.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 12.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationPlane: SKSpriteNode {
    
    private var originPosition: CGPoint = CGPoint()
    private var flyDestination: CGPoint = CGPoint()
    private var flyDuration: TimeInterval = 3
    
    func initialize(flyDuration: TimeInterval) {
        self.originPosition = self.position
        self.flyDestination = CGPoint(x: self.position.x * -2, y: self.position.y * -2)
        self.flyDuration = flyDuration
        self.isUserInteractionEnabled = false
        print("AnimationPlane init ", self.originPosition, self.flyDestination)
    }
    
    func getFlyDuration() -> TimeInterval{
        return self.flyDuration
    }
    
    func fly() {
        print("Planes flying")
        if (self.position != self.originPosition) { // plane not in starting position
            self.removeAllActions()
            self.position = self.originPosition
        }
        
        let flyAction = SKAction.move(to: self.flyDestination, duration: self.flyDuration)
        self.run(flyAction, completion: {
            self.reset()
        })
    }
    
    func reset() {
        self.position = self.originPosition
    }
}
