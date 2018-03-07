//
//  PackageFactory.swift
//  Cargonator
//
//  Created by René Penkert on 07.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation
import SpriteKit

class PackageFactory {
    static let sharedInstance = PackageFactory()
    func getNewPackage() -> SKShapeNode {
        let figure = Figure.randomFigure()
        switch figure {
        case Figure.circle:
            let circle = SKShapeNode(circleOfRadius: 40)
            circle.lineWidth = 1
            circle.fillColor = SKColor.white
            circle.fillTexture = SKTexture(imageNamed:"Paper_white")
            circle.zPosition = 0.3
           // circle.setScale(0.5)
            return circle
        case .square:
            var points = [CGPoint(x:0.0,y:0.0),
                          CGPoint(x:50.0,y:0.0),
                          CGPoint(x:50.0,y:50.0),
                          CGPoint(x:0.0,y:50.0),
                          CGPoint(x:0.0,y:0.0)
            ]
            let square = SKShapeNode(points: &points, count: points.count)
            square.lineWidth = 1
            square.fillColor = UIColor.white
            square.fillTexture = SKTexture(imageNamed: "Paper_brown")
            square.zPosition = 0.3
            //square.setScale(0.5)
            return square

        case .triangle:
            var points = [CGPoint(x:0.0,y:0.0),
                          CGPoint(x:50.0,y:50.0),
                          CGPoint(x:100.0,y:0.0),
                          CGPoint(x:0.0,y:0.0)
            ]
            let triangle = SKShapeNode(points: &points, count: points.count)
            triangle.lineWidth = 1
            triangle.fillColor = UIColor.white
            triangle.fillTexture = SKTexture(imageNamed: "Paper_green")
            triangle.zPosition = 0.3
            //triangle.setScale(0.5)
            return triangle
        case .trapeze:
            var pointsT = [CGPoint(x:0.0,y:0.0),
                           CGPoint(x:25,y:50),
                           CGPoint(x:75,y:50),
                           CGPoint(x:100,y:0.0),
                           CGPoint(x:0.0,y:0.0)
            ]
            let trapeze = SKShapeNode(points: &pointsT, count: pointsT.count)
            trapeze.lineWidth = 1
            trapeze.fillColor = UIColor.white
            trapeze.fillTexture = SKTexture(imageNamed: "Paper_yellow")
            //trapeze.setScale(0.5)
            trapeze.zPosition = 0.3
            return trapeze

        }
    }
}




