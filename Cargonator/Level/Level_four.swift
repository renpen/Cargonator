//
//  File.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

//This inheritance makes sure that every change in an level before this level is already applied to this level
class Level_four: Level_three {
    override init() {
        super.init()
        allowedColors = [Color.Paper_green,Color.Paper_brown]
    }
    
    override func getNextLevel() -> Level {
     return Level_five()
    }
}
