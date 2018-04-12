//
//  ProgressBuffer.swift
//  Cargonator
//
//  Created by René Penkert on 12.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class ProgressBuffer
{
    var score = Score()
    var seconds = 0
    init() {
        
    }
    func calcScore(package: Package) {
        self.score = Score(oldScore: self.score, deliveredPackage: package)
    }
    func addTime() {
        seconds += LevelEngine.sharedInstance.level.packageDeliveryAddingTime
    }
    func submit() -> ProgressBuffer {
        GameState.sharedInstance.addScore(score: self.score)
        GameState.sharedInstance.addTime(seconds: self.seconds)
        return ProgressBuffer()
    }
}
