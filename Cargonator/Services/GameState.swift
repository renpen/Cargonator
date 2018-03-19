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
    var playSceneDelegate: SpawnDelegate?
    
    private var activePackages = 0
    private var score = 0
    private var coins = 0
    private var packageSpawnTime:TimeInterval = 4
    private var timeInGame = 0
    
    // - MARK: Init
    
    init() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimeInGame), userInfo: nil, repeats: true)
    }
    
    func reset () {
        self.activePackages = 0
        self.score = 0
        self.coins = 0
        self.timeInGame = 0
        packageSpawnTime = 4
        setSpawnTimer()
    }
    
    // - MARK: Package Spawn Time
    
    @objc func increaseTimeInGame() {
        timeInGame += 1
    }
    
    func calcPackageSpawnTime () {
        if packageSpawnTime > 1 {
            packageSpawnTime -= 0.1
        }
        print(packageSpawnTime)
    }
    
    func calcInitialPackageSpawnTime() {
        switch SettingService.shared.difficulty {
        case .easy:
            packageSpawnTime = 4
        default:
            packageSpawnTime = 4
        }
    }
    
    // - MARK: Package Spawn
    
    func setSpawnTimer() {
        Timer.scheduledTimer(timeInterval: packageSpawnTime,
                             target: self,
                             selector: #selector(self.spawnPackage),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func spawnPackage() {
        playSceneDelegate?.spawnPackage()
        calcPackageSpawnTime()
        setSpawnTimer()
    }
    
    // - MARK: Active Package Calculation
    
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
