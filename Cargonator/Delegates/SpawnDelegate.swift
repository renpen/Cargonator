//
//  SpawnDelegate.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit

protocol SpawnDelegate {
    func spawnPackage()
    func updateScore(score: Score)
    func updateCountdown(countdown: Int)
    
}
