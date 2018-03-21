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
    private var score: Score = Score()
    private var coins = 0
    private var packageSpawnTime:TimeInterval = 4
    private var timeInGame = 0
    private var gameActive = false
    
    var streak = 1
    
    // - MARK: Init
    
    init() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimeInGame), userInfo: nil, repeats: true)
    }
    
    func startGame () {
        self.activePackages = 0
        self.score = Score()
        self.coins = 0
        self.timeInGame = 0
        self.gameActive = true
        calcInitialPackageSpawnTime()
        setSpawnTimer()
    }
    
    func endGame () {
        self.gameActive = false
    }
    
    // - MARK: Getter and Setter
    
    func getScore () -> Int{
        return self.score.value
    }
    
    // - MARK: Package Spawn Time
    
    @objc func increaseTimeInGame() {
        timeInGame += 1
    }
    
    func calcPackageSpawnTime () {
        if self.packageSpawnTime > SettingService.shared.difficulty.getLeastSpawnTime() {
            packageSpawnTime -= SettingService.shared.difficulty.getSpawnReduction()
        }
    }
    
    func calcInitialPackageSpawnTime() {
        packageSpawnTime = SettingService.shared.difficulty.getInitialSpawnTime()
    }
    
    // - MARK: Package Spawn
    
    func setSpawnTimer() {
        if (self.gameActive) {
            Timer.scheduledTimer(timeInterval: packageSpawnTime,
                                 target: self,
                                 selector: #selector(self.spawnPackage),
                                 userInfo: nil,
                                 repeats: false)
        }
    }
    
    @objc func spawnPackage() {
        print("Package spawned")
        playSceneDelegate?.spawnPackage()
        calcPackageSpawnTime()
        setSpawnTimer()
    }
    
    // - MARK: Score Calculation
    
    func calcScore(package: Package) {
        self.score = Score(oldScore: self.score, deliveredPackage: package)
    }
    
    // - MARK: Active Package Calculation
    
    func packageSpawned() {
        self.activePackages += 1
    }

    func packageDelivered(package: Package) {
        print("Entered packageDelivered with: " + String(self.activePackages))
        self.activePackages -= 1
        
        calcScore(package: package)
        
        if activePackages == 0 {
            gameViewController?.gameOver()
        }
    }
}
