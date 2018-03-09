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
    func getRandomPackage() -> Package {
        let figure = Figure.randomFigure()
        let package = getSpecificPackage(fig: figure)
        return package
    }
    func getSpecificPackage(fig : Figure) -> Package {
        switch fig {
        case Figure.circle:
            return generateCircle()
        case .square:
            return generateSquare()
        case .triangle:
            return generateTriangle()
        case .trapeze:
            return generateTrapaze()
        }
    }
    private func generateCircle() -> Package {
        let circle = Package(circleOfRadius: 40)
        circle.lineWidth = 1
        circle.fillColor = SKColor.white
        circle.fillTexture = SKTexture(imageNamed:"Paper_white")
        circle.zPosition = 2
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        
        return circle
    }
    private func generateSquare() -> Package {
        var sideLength = 50
        var points = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:50.0,y:0.0),
                      CGPoint(x:50.0,y:50.0),
                      CGPoint(x:0.0,y:50.0),
                      CGPoint(x:0.0,y:0.0)
        ]
        
        var path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 50.0))
        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))

        let square = Package(points: &points, count: points.count)
        square.lineWidth = 1
        square.fillColor = UIColor.white
        square.fillTexture = SKTexture(imageNamed: "Paper_brown")
        square.zPosition = 2
        
        square.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        return square
        

    }
    private func generateTriangle() -> Package {
        
        var path = CGMutablePath()
        path.move(to: CGPoint(x:0.0,y:0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 50.0))
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))

        /*var points = [CGPoint(x:0.0,y:0.0),
                      CGPoint(x:50.0,y:50.0),
                      CGPoint(x:100.0,y:0.0),
                      CGPoint(x:0.0,y:0.0)
        ]*/
        
        let triangle = Package(path: path)
        //let triangle = Package(points: &points, count: points.count)
        triangle.lineWidth = 1
        triangle.fillColor = UIColor.white
        triangle.fillTexture = SKTexture(imageNamed: "Paper_green")
        triangle.zPosition = 2
        
        triangle.physicsBody = SKPhysicsBody(polygonFrom: path)
        return triangle

    }
    private func generateTrapaze() -> Package {
        var pointsT = [CGPoint(x:0.0,y:0.0),
                       CGPoint(x:25,y:50),
                       CGPoint(x:75,y:50),
                       CGPoint(x:100,y:0.0),
                       CGPoint(x:0.0,y:0.0)
        ]
        
        var path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 25.0, y: 50.0))
        path.addLine(to: CGPoint(x: 75.0, y: 50.0))
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        path.addLine(to: CGPoint(x: 5.0, y: 0.0))
        
        //let trapeze = Package(points: &pointsT, count: pointsT.count)
        let trapeze = Package(path: path)
        trapeze.lineWidth = 1
        trapeze.fillColor = UIColor.white
        trapeze.fillTexture = SKTexture(imageNamed: "Paper_yellow")
        trapeze.zPosition = 2
        trapeze.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        return trapeze
    }
}




