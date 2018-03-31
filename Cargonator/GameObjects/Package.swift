//
//  Package.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 09.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import SpriteKit

class Package: SKShapeNode {
    
    //The initialition is just a placeholder that is set correclty in the PackageFactory
    var type = Figure.randomFigure()
    var color = Color.randomColor()
    
}
