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
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
    
    func getCountdownStarttime() -> Int
    {
        switch difficulty {
        case .easy:
            return 50
        case .medium:
            return 40
        case .hard:
            return 30
        case .veryhard:
            return 20
        case .extreme:
            return 15
        }
    }
    func getTimeIncrease() -> Int {
        switch difficulty {
        case .easy:
            return 4
        case .medium:
            return 3
        case .hard:
            return 2
        case .veryhard:
            return 1
        case .extreme:
            return 1
        }
    }
}
