//
//  GameScene.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 3/17/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var particle = Particle()
    var score = 0;
    

 
     let userDefults = UserDefaults.standard

    
    override func didMove(to view: SKView) {
        particle.spawnParticlesMenu(scene: self, xpos: 0, ypos: 500)
        
        if userDefults.value(forKey: "Difficulty") == nil{
           userDefults.set(0, forKey: "Difficulty")
        }
        
        
        
    }
    
    //Add particles to menu screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            
            //Play Button
            if atPoint(location).name == "Play"{
                
                NSLog("Play Button Touched")
                if let scene = GameSceneClass(fileNamed:"GameScene"){
                 

                    scene.scaleMode = .aspectFill;
                    view?.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                    
                }
                print(score)
                
                
            }
            
            //Options button
            if atPoint(location).name == "Options"{
                
                NSLog("Options Button Touched")
                
                if let scene = OptionSceneClass(fileNamed:"OptionScene"){
                    scene.scaleMode = .aspectFill;
                    view?.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                    
                }
                
                
                
                
                
            }
            
            //About button
            
            if atPoint(location).name == "Charcters"{
                
                NSLog("Options Button Touched")
                
                if let scene = OptionSceneClass(fileNamed:"CharcterSelection"){
                    scene.scaleMode = .aspectFill;
                    view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1))
                    
                }
                
                
                
                
                
            }

            
            
            
            
        }
        
    }
    
    
    
    
    
    
    
}

