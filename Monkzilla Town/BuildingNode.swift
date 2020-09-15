//
//  BuildingNode.swift
//  Monkzilla Town
//
//  Created by DDDD on 15/09/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import SpriteKit
import UIKit

class BuildingNode: SKSpriteNode {
    var currentImage: UIImage!
    
    func setup() {
        name = "building"
        
        currentImage = drawBuilding(size: size)
        texture = SKTexture(image: currentImage)
        
        configurePhysics()
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitmask = CollisionTypes.building.rawValue
        physicsBody?.contactTestBitmask = CollisionTypes.banana.rawValue
    }
    
}
