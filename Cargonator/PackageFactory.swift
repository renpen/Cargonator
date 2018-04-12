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
        let level = LevelEngine.sharedInstance.level
        let figure = level.randomFigure()
        let color = level.randomColor()
        let package = getSpecificPackage(fig: figure, color: color)
        package.type = figure
        return package
    }
    func getSpecificPackage(fig : Figure, color: Color) -> Package {
        switch fig {
        case Figure.circle:
            return generateCircle(color: color)
        case .square:
            return generateSquare(color: color)
        case .triangle:
            return generateTriangle(color: color)
        case .trapeze:
            return generateTrapaze(color: color)
        }
    }
    private func generateCircle(color: Color) -> Package {
        let circle = Package(circleOfRadius: 40)
        circle.lineWidth = 1
        circle.fillColor = SKColor.white
        circle.color = color
        circle.fillTexture = SKTexture(imageNamed: color.rawValue)
        circle.zPosition = 2
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        
        return circle
    }
    private func generateSquare(color: Color) -> Package {
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 50.0))
        path.addLine(to: CGPoint(x: 0.0, y: 50.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))
        
        let square = Package(path: path)
        
        square.lineWidth = 1
        square.fillColor = UIColor.white
        square.color = color
        square.fillTexture = SKTexture(imageNamed: color.rawValue)
        square.zPosition = 2
        
        square.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        return square
        

    }
    private func generateTriangle(color: Color) -> Package {
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x:0.0,y:0.0))
        path.addLine(to: CGPoint(x: 50.0, y: 50.0))
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))

        let triangle = Package(path: path)
        triangle.lineWidth = 1
        triangle.fillColor = UIColor.white
       
        triangle.color = color
        triangle.fillTexture = SKTexture(imageNamed: color.rawValue)
        triangle.zPosition = 2
        
        triangle.physicsBody = SKPhysicsBody(polygonFrom: path)
        return triangle

    }
    private func generateTrapaze(color: Color) -> Package {

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 25.0, y: 50.0))
        path.addLine(to: CGPoint(x: 75.0, y: 50.0))
        path.addLine(to: CGPoint(x: 100.0, y: 0.0))
        path.addLine(to: CGPoint(x: 5.0, y: 0.0))
        
        let trapeze = Package(path: path)
        trapeze.lineWidth = 1
        trapeze.fillColor = UIColor.white
       
        trapeze.color = color
        trapeze.fillTexture = SKTexture(imageNamed: color.rawValue)
       
        trapeze.zPosition = 2
        trapeze.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        return trapeze
    }
}




