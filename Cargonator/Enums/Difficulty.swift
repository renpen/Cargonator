//
//  Level.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

enum Difficulty: Int {
    case easy = 1
    case medium = 2
    case hard = 3
    case veryhard = 4
    case extreme = 5
    
    func getSpawnReduction () -> TimeInterval{
        return 0.1
    }
    
    func getLeastSpawnTime () -> TimeInterval{
        
        var leastSpawnTime = TimeInterval()
        
        switch self {
        case .easy:
            leastSpawnTime = 3
            break
        case .medium:
            leastSpawnTime = 2.5
            break
        case .hard:
            leastSpawnTime = 2
            break
        case .veryhard:
            leastSpawnTime = 1.5
            break
        case .extreme:
            leastSpawnTime = 1
            break
        }
        return leastSpawnTime
    }
    
    func getInitialSpawnTime () -> TimeInterval{
        var initialSpawnTime = TimeInterval()
        
        switch self {
        case .easy:
            initialSpawnTime = 8
            break
        case .medium:
            initialSpawnTime = 7
            break
        case .hard:
            initialSpawnTime = 6
            break
        case .veryhard:
            initialSpawnTime = 5
            break
        case .extreme:
            initialSpawnTime = 4
            break
        }
        return initialSpawnTime
    }
}
