//
//  PopgraphScene.swift
//  populationgraphs
//
//  Created by Rodney Dyer on 11/21/18.
//  Copyright © 2018 Rodney Dyer. All rights reserved.
//

import Cocoa
import SceneKit

class GraphScene: SCNScene {
    
    var cameraNode: SCNNode!
    var lightNode: SCNNode!
    var gridNode: SCNNode!
    var groundNode: SCNNode!
    
    
    func config() {
    
        let floor = SCNFloor()
        floor.reflectivity = 0.1
        let floorMaterial = SCNMaterial()
        floorMaterial.diffuse.contents = NSColor.darkGray
        floor.materials = [floorMaterial]
        groundNode = SCNNode(geometry: floor)
        groundNode.position = SCNVector3(x: 0, y: -11, z: 0)
        rootNode.addChildNode(groundNode)
        
        
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.intensity = 75.0
        rootNode.light = ambientLight
        
        gridNode = SCNNode(geometry: SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1) )
        gridNode.position = SCNVector3(x: 0.0, y: 0.0, z: 0.0)
        rootNode.addChildNode( gridNode )
        
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0.0, y: 10.0, z: 50)
        cameraNode.constraints = [ SCNLookAtConstraint(target: rootNode) ]
        rootNode.addChildNode(cameraNode)

        lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 50)
        rootNode.addChildNode(lightNode)
        
        physicsWorld.gravity = SCNVector3(x: 0, y: 0, z: 0)
        
    }

}




extension GraphScene {
    
    public func removeAllNodes() {
        rootNode.enumerateChildNodes { (node, stop) in
            if node != cameraNode &&
                node != lightNode &&
                node != gridNode &&
                node != groundNode {
                node.removeFromParentNode()
            }
        }
    }
}