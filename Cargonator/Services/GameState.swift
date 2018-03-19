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
        calcInitialPackageSpawnTime()
        setSpawnTimer()
    }
    
    // - MARK: Getter and Setter
    
    func getScore () -> Int{
        return self.score
    }
    
    // - MARK: Package Spawn Time
    
    @objc func increaseTimeInGame() {
        timeInGame += 1
    }
    
    func calcPackageSpawnTime () {
        if packageSpawnTime > 1 {
            packageSpawnTime -= 0.1
        }
    }
    
    func calcInitialPackageSpawnTime() {
        switch SettingService.shared.difficulty {
        case .easy:
            packageSpawnTime = 10
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
        self.activePackages += 1
        calcPackageSpawnTime()
        setSpawnTimer()
    }
    
    // - MARK: Score Calculation
    
    func calcScore(package: Package) {
        switch package.type {
        case .circle:
            score += 30
            break
        case .square:
            score += 10
            break
        case .trapeze:
            score += 20
            break
        case .triangle:
            score += 20
            break
        }
    }
    
    // - MARK: Active Package Calculation

    func packageDelivered(package: Package) {
        self.activePackages -= 1
        
        calcScore(package: package)
        
        if !(activePackages > 0) {
            gameViewController?.gameOver()
        }
    }
}
