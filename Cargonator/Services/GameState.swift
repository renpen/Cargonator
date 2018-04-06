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
    private var score: Score = Score() {
        didSet {
            playSceneDelegate?.updateScore(score: score)
        }
    }
    private var coins = 0
    private var packageSpawnTime:TimeInterval = 4
    private var timeInGame = 0
    private var gameActive = false
    private var countdown = Timer()
    private var seconds = SettingService.shared.getCountdownStarttime(){
        didSet {
            playSceneDelegate?.updateCountdown(countdown: seconds)
        }
    }
    
    var streak = 1
    
    // - MARK: Init
    
    init() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimeInGame), userInfo: nil, repeats: true)
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateCountdown)), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        if seconds > 1 {
            seconds -= 1
        }
        else
        {
            endGame()
            gameViewController?.gameOver()
        }
        
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
    
    func getCoins() -> Int {
        return Int(Double(score.value) * 0.4)
    }
    
    // - MARK: Active Package Calculation
    
    func packageSpawned() {
        self.activePackages += 1
    }

    func packageDelivered(package: Package) {
        print("Entered packageDelivered with: " + String(self.activePackages))
        self.activePackages -= 1
        
        calcScore(package: package)
        increaseTime()
        if activePackages == 0 {
            gameViewController?.gameOver()
        }
    }
    func increaseTime() {
        seconds += SettingService.shared.getTimeIncrease()
    }
}
