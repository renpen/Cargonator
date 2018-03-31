//
//  PackageColor.swift
//  Cargonator
//
//  Created by René Penkert on 31.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

enum Color : String {
    case Paper_yellow
    case Paper_white
    case Paper_green
    case Paper_brown
    
    static func randomColor() -> Color
    {
        var colors = [Color.Paper_brown,Color.Paper_green,Color.Paper_white,Color.Paper_yellow];
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[index]
    }
}
