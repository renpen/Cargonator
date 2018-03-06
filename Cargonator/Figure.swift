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
        index = arc4random_uniform(UIInt32(figures.count))
        return figures[index]
    }
}
#
