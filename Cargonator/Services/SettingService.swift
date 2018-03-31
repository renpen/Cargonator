//
//  SettingService.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class SettingService {
    static let shared = SettingService()
    var difficulty:Difficulty = .easy
    var rotateTrucks: Bool {
        if (!(difficulty == .easy) && !(difficulty == .medium))
        {
            // if the difficulty is higher than easy or medium, let the trucks rotate their Colors and Figures
            return true
        }
        else
        {
            return false
        }
    }
    var diversePackageGeneration: Bool {
        if (!(difficulty == .easy))
        {
            // if the difficulty is higher than easy or medium, let the trucks rotate their Colors and Figures
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
}
