//
//  Level_three.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class Level_three: Level_two {
    override init() {
        super.init()
        allowedFigures = [Figure.circle,Figure.square,Figure.trapeze,Figure.triangle]
    }
    
    override func getNextLevel() -> Level {
        
        return Level_four()
    }

}
