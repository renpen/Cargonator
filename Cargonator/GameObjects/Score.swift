//
//  ScoreService.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 20.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class Score {
    
    let value: Int
    
    let triangleValue = 20
    let circleValue = 10
    let trapezeValue = 25
    let squareValue = 30
    
    init(oldScore: Score, deliveredPackage: Package) {
        
        let addedValue: Int
        
        switch deliveredPackage.type {
        case .circle:
            addedValue = circleValue
            break
        case .trapeze:
            addedValue = trapezeValue
            break
        case .triangle:
            addedValue = triangleValue
            break
        case .square:
            addedValue = squareValue
            break
        }
        
        self.value = (oldScore.value + GameState.sharedInstance.streak * addedValue)
    }
    
    init() {
        self.value = 0
    }
}
