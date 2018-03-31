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
    var changePackageColors = SettingService.shared.diversePackageGeneration
    func getRandomPackage() -> Package {
        let figure = Figure.randomFigure()
        let color = Color.randomColor()
        let package = getSpecificPackage(fig: figure, color: color)
        package.type = figure
        return package
    }
    func getSpecificPackage(fig : Figure, color: Color) -> Package {
        //update in case the difficulty changed
        self.changePackageColors = SettingService.shared.diversePackageGeneration
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
        if changePackageColors {
            circle.color = color
            circle.fillTexture = SKTexture(imageNamed: color.rawValue)
        }
        else
        {
            circle.color = Color.Paper_white
            circle.fillTexture = SKTexture(imageNamed:"Paper_white")
        }
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
        if changePackageColors {
            square.color = color
            square.fillTexture = SKTexture(imageNamed: color.rawValue)
        }
        else
        {
            square.color = Color.Paper_brown
            square.fillTexture = SKTexture(imageNamed: "Paper_brown")
        }
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
        if changePackageColors {
            triangle.color = color
            triangle.fillTexture = SKTexture(imageNamed: color.rawValue)
        }
        else
        {
            triangle.color = Color.Paper_green
            triangle.fillTexture = SKTexture(imageNamed: "Paper_green")
        }
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
        if changePackageColors {
            trapeze.color = color
            trapeze.fillTexture = SKTexture(imageNamed: color.rawValue)
        }
        else
        {
            trapeze.color = Color.Paper_yellow
            trapeze.fillTexture = SKTexture(imageNamed: "Paper_yellow")
        }
        trapeze.zPosition = 2
        trapeze.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        return trapeze
    }
}




