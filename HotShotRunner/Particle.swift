//
//  Particle.swift
//  HotShotRunner
//
//  Created by Tyler M on 4/7/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit

class Particle:SKSpriteNode{

  

 
    func spawnParticlesDeath(scene:SKScene,xpos:CGFloat,ypos:CGFloat){
    
        
        let deathParticlesPath = Bundle.main.path(forResource: "DeathParticle", ofType: "sks")
        let  deathParticlesNode = NSKeyedUnarchiver.unarchiveObject(withFile: deathParticlesPath!)as! SKEmitterNode
        
        
        deathParticlesNode.position = CGPoint(x: xpos , y: ypos)
        deathParticlesNode.numParticlesToEmit = 40
        
        scene.addChild(deathParticlesNode)
        
        
    }

    func spawnParticlesMenu(scene:SKScene,xpos:CGFloat,ypos:CGFloat){
        
        
        let menuParticlesPath = Bundle.main.path(forResource: "MenuParticle", ofType: "sks")
        let  menuParticlesNode = NSKeyedUnarchiver.unarchiveObject(withFile: menuParticlesPath!)as! SKEmitterNode
        
    
        menuParticlesNode.position = CGPoint(x: xpos , y: ypos)
        menuParticlesNode.zPosition = -21
        
       
   
 
        
        scene.addChild(menuParticlesNode)
        
        
    }



}
