//
//  OptionSceneClass.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 4/19/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit
import GameplayKit

class OptionSceneClass: SKScene {
    
    
    let userDefults = UserDefaults.standard
    
    var easyButton:SKSpriteNode?
    var mediumButton:SKSpriteNode?
    var hardButton:SKSpriteNode?
    var backButton:SKSpriteNode?
    var Difficulty = 0;
    var isMuted = 0;
    
    var muteButton:SKSpriteNode?
 
    
    var start:(location:CGPoint, time:TimeInterval)?

    
    let minDistance:CGFloat = 25
    let minSpeed:CGFloat = 1000
    let maxSpeed:CGFloat = 6000
    
    
    override func didMove(to view: SKView) {
        startFunc()
        swipeGestures()
       
    }
    
    
    
    func startFunc(){
        //Initalizer Code
        easyButton = childNode(withName: "easyButton")as? SKSpriteNode
        mediumButton = childNode(withName: "mediumButton")as? SKSpriteNode
        hardButton = childNode(withName: "hardButton")as? SKSpriteNode
        backButton = childNode(withName: "Back")as? SKSpriteNode
        muteButton = childNode(withName: "MuteButton")as? SKSpriteNode
        

        
        currentDifficulty()
        
        
        
        
        
    }
    
    func swipeGestures(){
    
        
    
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var swiped = false
        if let touch = touches.first, let startTime = self.start?.time,
            let startLocation = self.start?.location {
            let location = touch.location(in:self)
            let dx = location.x - startLocation.x
            let dy = location.y - startLocation.y
            let distance = sqrt(dx*dx+dy*dy)
            
            // Check if the user's finger moved a minimum distance
            if distance > minDistance {
                let deltaTime = CGFloat(touch.timestamp - startTime)
                let speed = distance / deltaTime
                
                // Check if the speed was consistent with a swipe
                if speed >= minSpeed && speed <= maxSpeed {
                    
                    // Determine the direction of the swipe
                    let x = abs(dx/distance) > 0.4 ? Int(sign(Float(dx))) : 0
                    let y = abs(dy/distance) > 0.4 ? Int(sign(Float(dy))) : 0
                    
                    swiped = true
                    switch (x,y) {
                    case (-1,0):
                        print("swiped left")
                    case (1,0):
                        print("swiped right")
                        back();
                    default:
                        swiped = false
                        break
                    }
                }
            }
        }
        start = nil
        if !swiped {
            // Process non-swipes (taps, etc.)
            print("not a swipe")
        }
    }
    
    
    
    //Check what the difficulty is currently set to.
    
    func currentDifficulty(){
        
        if let difficulty = userDefults.value(forKey: "Difficulty"){
            
            switch(difficulty as! Int){
                
            case 0:
                easyButton?.texture = SKTexture(imageNamed:"selectedEasy")
                mediumButton?.texture = SKTexture(imageNamed:"MediumButton")
                hardButton?.texture = SKTexture(imageNamed:"HardButton")
                break;
            case 1:   mediumButton?.texture = SKTexture(imageNamed:"selectedMedium")
            easyButton?.texture = SKTexture(imageNamed:"Easy Button")
            hardButton?.texture = SKTexture(imageNamed:"HardButton")
            break;
            case 2:  hardButton?.texture = SKTexture(imageNamed:"selectedHard")
            mediumButton?.texture = SKTexture(imageNamed:"MediumButton")
            easyButton?.texture = SKTexture(imageNamed:"Easy Button")
            break;
            default:
                easyButton?.texture = SKTexture(imageNamed:"selectedEasy")
                mediumButton?.texture = SKTexture(imageNamed:"MediumButton")
                hardButton?.texture = SKTexture(imageNamed:"HardButton")
                break;
                
                
                
                
                
                
            }
            
            
        }
  
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            start = (touch.location(in:self), touch.timestamp)
        }
        
        for touch in touches {
            
            let location = touch.location(in: self);
            
            
            if atPoint(location).name == "easyButton"{
                easyButton?.texture = SKTexture(imageNamed:"selectedEasy")
                mediumButton?.texture = SKTexture(imageNamed:"MediumButton")
                hardButton?.texture = SKTexture(imageNamed:"HardButton")
                userDefults.set(0, forKey: "Difficulty")
            }
            
            if atPoint(location).name == "mediumButton"{
                mediumButton?.texture = SKTexture(imageNamed:"selectedMedium")
                easyButton?.texture = SKTexture(imageNamed:"Easy Button")
                hardButton?.texture = SKTexture(imageNamed:"HardButton")
                userDefults.set(1, forKey: "Difficulty")
                
            }
            
            if atPoint(location).name == "hardButton"{
                hardButton?.texture = SKTexture(imageNamed:"selectedHard")
                mediumButton?.texture = SKTexture(imageNamed:"MediumButton")
                easyButton?.texture = SKTexture(imageNamed:"Easy Button")
                userDefults.set(2, forKey: "Difficulty")
                
            }
            
            
            if atPoint(location).name == "MuteButton" {
            
                if (isMuted == 0){
                    muteButton?.texture = SKTexture(imageNamed:"Mute")
                    isMuted = 1;
                    userDefults.set(isMuted, forKey: "Mute")
                
                }else{
                  muteButton?.texture = SKTexture(imageNamed:"notMuted")
                      isMuted = 0;
                    userDefults.set(isMuted, forKey: "Mute")
                }
                
                
            
            }
            
            
            if atPoint(location).name == "Back"{
                
                back()
                
            }
            
            
        }
        
     
        
    }
    func back(){
        if let scene = MenuScene(fileNamed:"MenuScene"){ //Sets Scene to the Menu Scene
            
            scene.scaleMode = .aspectFill;
            view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1)) //Begins a transiton Animation
            
        }

    
    }
    
    
}
