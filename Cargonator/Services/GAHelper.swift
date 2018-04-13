//
//  GAHelper.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 13.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class GAHelper {
    static let shared = GAHelper()
    
    func postGameOver(reason: GameOverReason) {
        let levelName = LevelEngine.sharedInstance.level.name
        let score = GameState.sharedInstance.getScore()
        GameAnalytics.addProgressionEvent(with: GAProgressionStatusFail, progression01: "Game", progression02: levelName, progression03: nil, score:score)
        GameAnalytics.addDesignEvent(withEventId: "Level:Lost:To:" + reason.rawValue)
    }
}

enum GameOverReason: String{
    case TimeOver
    case BlackMail
    case WrongTruck
}
