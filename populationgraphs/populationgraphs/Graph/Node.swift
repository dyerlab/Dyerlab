//
//  SKNode.swift
//  populationgraphs
//
//  Created by Rodney Dyer on 1/2/19.
//  Copyright © 2019 Rodney Dyer. All rights reserved.
//

import Foundation
import SpriteKit




class Node : SKSpriteNode {
    
    var label: String = "Bob"
    let nodeCategoryBitmask: UInt32 = 0x1 << 1
    
    init() {
        let texture = SKTexture(imageNamed: "Node")
        super.init(texture: texture, color: NSColor.orange, size: texture.size() )
        
        physicsBody = SKPhysicsBody(circleOfRadius: texture.size().width/2.0 )
        self.physicsBody?.categoryBitMask = nodeCategoryBitmask
        self.physicsBody?.contactTestBitMask = nodeCategoryBitmask
        self.physicsBody?.collisionBitMask = nodeCategoryBitmask
        self.physicsBody?.affectedByGravity = false
        
        let repulsionField = SKFieldNode.radialGravityField()
        repulsionField.strength = -0.01
        repulsionField.isEnabled = true
        self.addChild(repulsionField)
        
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


