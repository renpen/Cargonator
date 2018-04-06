//
//  Level_five.swift
//  Cargonator
//
//  Created by René Penkert on 06.04.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

class Level_five : Level_four
{
    override init() {
        super.init()
        allowedColors = [Color.Paper_brown,Color.Paper_green,Color.Paper_white,Color.Paper_yellow]
    }
    
    override func getNextLevel() -> Level {
        return Level_five()
    }
}
