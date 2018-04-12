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
        var requiredPackages = 7;
    }
    
    override func getNextLevel() -> Level {
        return Level_three()
    }
}
