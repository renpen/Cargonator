//
//  Level.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class Level {
    
    internal var allowedFigures = [Figure.square]
    internal var allowedColors = [Color.Paper_brown]
    var fastDelivery = false
    
    func getNextLevel() -> Level
    {
        return Level_two()
    }
    
    func randomFigure() -> Figure
    {
        let index = Int(arc4random_uniform(UInt32(allowedFigures.count)))
        return allowedFigures[index]
    }
    func randomColor() -> Color
    {
        let index = Int(arc4random_uniform(UInt32(allowedColors.count)))
        return allowedColors[index]
    }

}
