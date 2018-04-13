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
    private var packageCount = 1
    private var score: Score = Score() {
        didSet {
            playSceneDelegate?.updateScore(score: score)
        }
    }
    private var coins = 0
    private var startTime: Double = 0
    private var time: Double = 0
    private var packageSpawnTime:TimeInterval = 4
    private var timeInGame = 0
    private var gameActive = false
    private var countdown = Timer()
    private var advance = Timer()
    private var countdownTime = 20 {
        didSet {
            playSceneDelegate?.updateCountdown(countdown: countdownTime)
        }
    }
    var streak = 1
    
    // - MARK: Init
    
    init() {
        /*Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.advanceTimer), userInfo: nil, repeats: true)
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateCountdown)), userInfo: nil, repeats: true)
        startTime = Date().timeIntervalSinceReferenceDate*/
    }
    
    @objc func updateCountdown() {
        if countdownTime > 1 {
            countdownTime -= 1
        }
        else
        {
            endGame()
            GAHelper.shared.postGameOver(reason: GameOverReason.TimeOver)
            gameViewController?.gameOver()
        }
        
    }
    func startGame () {
        self.activePackages = 0
        self.score = Score()
        self.coins = 0
        self.timeInGame = 0
        self.gameActive = true
        
        LevelEngine.sharedInstance.level = Level()
        GameAnalytics.addProgressionEvent(with: GAProgressionStatusStart, progression01: "Game", progression02: LevelEngine.sharedInstance.level.name, progression03: nil)
        
        advance = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.advanceTimer), userInfo: nil, repeats: true)
        countdown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateCountdown)), userInfo: nil, repeats: true)
        startTime = Date().timeIntervalSinceReferenceDate
        
        countdownTime = 20
    }
    
    func endGame () {
        self.gameActive = false
        advance.invalidate()
        countdown.invalidate()
    }
    
    // - MARK: Getter and Setter
    
    func getScore () -> Int{
        return self.score.value
    }
    
    // - MARK: Package Spawn Time
    
    @objc func advanceTimer() {
        time = Date().timeIntervalSinceReferenceDate - startTime
        if time > LevelEngine.sharedInstance.level.packageSpawnSeconds {
            spawnPackage()
            startTime = Date().timeIntervalSinceReferenceDate
        }
    }
    
    @objc func spawnPackage() {
        print("Package spawned")
        playSceneDelegate?.spawnPackage()
    }
    
    // - MARK: Score Calculation
    
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
        packageCount += 1;
        if(packageCount % LevelEngine.sharedInstance.level.requiredPackages == 0)
        {
            packageCount = 1
            GameAnalytics.addProgressionEvent(with: GAProgressionStatusComplete, progression01: "Game", progression02: LevelEngine.sharedInstance.level.name, progression03: nil)
            LevelEngine.sharedInstance.nextLevel()
            GameAnalytics.addProgressionEvent(with: GAProgressionStatusStart, progression01: "Game", progression02: LevelEngine.sharedInstance.level.name, progression03: nil)
        }
    }
    func addTime(seconds : Int)
    {
        countdownTime += seconds
    }
    func addScore(score : Score)
    {
        self.score = Score(score: self.score.value + score.value)
    }
}
