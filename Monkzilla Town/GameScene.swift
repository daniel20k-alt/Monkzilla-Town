//
//  GameScene.swift
//  Monkzilla Town
//
//  Created by DDDD on 14/09/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case banana = 1
    case building = 2
    case player = 4
}

class GameScene: SKScene {
    var buildings = [BuildingNode]()
    weak var viewController: GameViewController?
    
    override func didMove(to view: SKView) {
        
        //creating the sky
        backgroundColor = UIColor(hue: 0.669, saturation: 0.99, brightness: 0.67, alpha: 1)
        createBuildings()
    }
    
    func createBuildings() {
        var currentX: CGFloat = -15
        
        while currentX < 1024 {
            let size = CGSize(width: Int.random(in: 2...4) * 40, height: Int.random(in: 300...600))
            currentX += size.width + 2
            
            let building = BuildingNode(color: .red, size: size)
            building.position = CGPoint(x: currentX - (size.width) / 2, y: size.height / 2)
            
            building.setup() //setting up the building
            addChild(building) //adding the buildings to the scene
            
            buildings.append(building) //keeping track of all buildings
        }
    }
        
        func launch(angle: Int, velocity: Int) {
            
        }

}
