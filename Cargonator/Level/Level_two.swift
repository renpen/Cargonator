//
//  Level_two.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

//this inheritance makes sure that 
class Level_two: Level {
   override init() {
    super.init()
        allowedFigures = [Figure.circle,Figure.square]
        name = "Level2"
        requiredPackages = 7;
        packageSpawnSeconds = 3.0
    }
    
    override func getNextLevel() -> Level {
        return Level_three()
    }
}
