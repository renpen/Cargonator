//
//  Figure.swift
//  Cargonator
//
//  Created by René on 06.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import Foundation

enum Figure {
    case square
    case triangle
    case circle
    case trapeze
    static func randomFigure() -> Figure
    {
        var figures = [Figure.circle,Figure.square, Figure.trapeze, Figure.triangle]
        let index = Int(arc4random_uniform(UInt32(figures.count)))
        return figures[index]
    }
}

