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
    var type = Figure.circle
    var color = Color.Paper_green
    var isBlackMail = false {
        didSet {
            if self.isBlackMail {
                self.fillTexture = nil
                self.fillColor = UIColor.black
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.removeFromParent()
                }
            }
        }
    }
}
