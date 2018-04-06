//
//  GameEngine.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class LevelEngine {
    static let sharedInstance = LevelEngine()
    var level = Level()
    
    
    func nextLevel()
    {
        level = level.getNextLevel()
    }
}
