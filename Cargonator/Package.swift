//
//  Package.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 09.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import SpriteKit

class Package: SKShapeNode {
    
    var type = Figure.randomFigure()
    
    /*
    // left, right, top and bottom represent the boarders of the package related to the position
    var left = CGFloat()
    var right = CGFloat()
    var top = CGFloat()
    var bottom = CGFloat()
    
    func calcBoarders(input: [Any]) {
        switch type {
        case .circle:
            let radius = input[0] as! CGFloat
            left = -radius
            right = radius
            top = radius
            bottom = -radius
            break
        case .square:
            left = 0
            bottom = 0
            right = (input[2] as! CGPoint).x
            top = (input[2] as! CGPoint).y
            break
        case .triangle:
            left = 0
            bottom = 0
            right = (input[2] as! CGPoint).x
            top = (input[1] as! CGPoint).y
            break
        case .trapeze:
            left = 0
            bottom = 0
            right = (input[3] as! CGPoint).x
            top = (input[1] as! CGPoint).y
            break
        }
    }*/
}
