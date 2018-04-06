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
            return 80
        case .medium:
            return 70
        case .hard:
            return 60
        case .veryhard:
            return 50
        case .extreme:
            return 45
        }
    }
}
