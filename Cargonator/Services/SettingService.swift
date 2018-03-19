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
    
    func loadUserSettings() {
        
    }
    
    func setDifficulty(difficulty: Difficulty) {
        self.difficulty = difficulty
    }
}
