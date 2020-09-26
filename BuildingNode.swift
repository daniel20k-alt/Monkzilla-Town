//
//  BuildingNode.swift
//  Monkzilla Town
//
//  Created by DDDD on 16/09/2020.
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
        self.physicsBody = SKPhysicsBody(texture: texture!, size: self.size)
        physicsBody?.isDynamic = false
        
        physicsBody?.categoryBitMask = CollisionTypes.building.rawValue //what it represents
        physicsBody?.collisionBitMask = CollisionTypes.banana.rawValue //what it interacts with
        physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
    }
    
    func drawBuilding(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            let color: UIColor
            
            switch Int.random(in: 0...2) {
            case 0:
                color = UIColor(hue: 0.502, saturation: 0.98, brightness: 0.67, alpha: 1)
            case 1:
                color = UIColor(hue: 0.999, saturation: 0.99, brightness: 0.67, alpha: 1)
            default:
                color = UIColor(hue: 0, saturation: 0, brightness: 0.67, alpha: 1)
            }
            //fill the building with these colors
            color.setFill()
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fill)
            
            let lightOnColor = UIColor(hue: 0.19, saturation: 0.67, brightness: 0.99, alpha: 1)
            let lightOffColor = UIColor(hue: 0, saturation: 0, brightness: 0.34, alpha: 1)
            
            //nested loop for inserting the lights
            for row in stride(from: 10, to: Int(size.height - 10), by: 40) {
                for column in stride(from: 10, to: Int(size.width - 10), by: 40) {
                    if Bool.random() { //return a bool randomly
                        lightOnColor.setFill()
                    } else {
                        lightOffColor.setFill()
                    }
                    
                    ctx.cgContext.fill(CGRect(x: column, y: row, width: 20, height: 20))
                }
            }
        }
        return img

    }
    
    func hit(at point: CGPoint) {
        //finding out where the banana has hit the target in core graphics space
        let convertedPoint = CGPoint(x: point.x + size.width / 2, y: abs(point.y - (size.height / 2)))
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let img = renderer.image  { ctx in
            currentImage.draw(at: .zero) //start at zero point defined above
            
            ctx.cgContext.addEllipse(in: CGRect(x: convertedPoint.x - 32, y: convertedPoint.y - 32, width: 64, height: 64)) //creating the ellipse
            ctx.cgContext.setBlendMode(.clear) //clearing the current hit spot
            ctx.cgContext.drawPath(using: .fill)
        }
        
        texture = SKTexture(image: img)
        currentImage = img //update the new img
        configurePhysics() //refresh
    }
}
