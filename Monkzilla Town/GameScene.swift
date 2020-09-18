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
    
    //defining the SKSpriteNodes - player 1, player 2 and the throwing object
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var banana: SKSpriteNode!
    
    var currentPlayer = 1 //to keep track who's turn it is
    
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
    
    func createPlayers() {
        player1 = SKSpriteNode(imageNamed: "player")
        player1.name = "player1"
        player1.physicsBody = SKPhysicsBody(circleOfRadius: player1.size.width / 2)
        player1.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue //identifying category
        player1.physicsBody?.collisionBitMask = CollisionTypes.banana.rawValue //who will bounce off
        player1.physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
        player1.physicsBody?.isDynamic = false
        
        let player1Building = buildings[1]
        player1.position = CGPoint(x: player1Building.position.x, y: player1Building.position.y + (player1Building.size.height + player1.size.height) / 2) //the position of player 1
        
        addChild(player1)
        
        player2 = SKSpriteNode(imageNamed: "player")
            player2.name = "player2"
            player2.physicsBody = SKPhysicsBody(circleOfRadius: player2.size.width / 2)
            player2.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue //identifying category
            player1.physicsBody?.collisionBitMask = CollisionTypes.banana.rawValue //who will bounce off
            player1.physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
            player1.physicsBody?.isDynamic = false
            
        let player2Building = buildings[buildings.count - 2]
            player2.position = CGPoint(x: player2Building.position.x, y: player2Building.position.y + (player2Building.size.height + player2.size.height) / 2) //the position of player 2
            
            addChild(player2)
        
    }
}
