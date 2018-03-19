//
//  GameState.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit

class GameState {
    static let sharedInstance = GameState()
    
    var gameViewController: NavigationDelegate?
    
    private var activePackages = 0
    private var score = 0
    private var coins = 0
    
    func reset () {
        self.activePackages = 0
        self.score = 0
        self.coins = 0
    }
    
    func packageSpawned() {
        self.activePackages = self.activePackages + 1
    }
    
    func packageDelivered() {
        self.activePackages = self.activePackages - 1
        if !(activePackages > 0) {
            gameViewController?.gameOver()
        }
    }
}
