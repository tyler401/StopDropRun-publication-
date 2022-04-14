//
//  CharacterSelectionClassw.swift
//  StopDropRun
//
//  Created by Tyler Makhoul on 4/29/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterSelectionClass: SKScene {
    
    let userDefults = UserDefaults.standard
    
    var square1 :SKSpriteNode?
    var square2 :SKSpriteNode?
    var square3 :SKSpriteNode?
    
    var balanceTxt :SKLabelNode?
    
    var bought1 = false
      var bought2 = false
      var bought3 = false
    var coinBalance = 0

    var text2 :SKLabelNode?
    var coin2 :SKSpriteNode?
    var text3 :SKLabelNode?
    var coin3 :SKSpriteNode?
    
    
    var start:(location:CGPoint, time:TimeInterval)?
    
    
    let minDistance:CGFloat = 25
    let minSpeed:CGFloat = 1000
    let maxSpeed:CGFloat = 6000
    


    
    override func update(_ currentTime: TimeInterval) {
        
       balanceTxt?.text = "Balance: $\(coinBalance)"
        if (coinBalance < 0){
            coinBalance = 0;
             userDefults.set(coinBalance, forKey: "bank")
        }
        
        
    }
    
    override func didMove(to view: SKView) {
        square1 = childNode(withName: "Square1") as? SKSpriteNode
        square2 = childNode(withName: "square2") as? SKSpriteNode
        square3 = childNode(withName: "Square3") as? SKSpriteNode
        balanceTxt = childNode(withName: "Balance")as? SKLabelNode
        
    
        text2 = childNode(withName: "text2")as? SKLabelNode
        text3 = childNode(withName: "text3")as? SKLabelNode

        coin2 = childNode(withName: "coin2")as? SKSpriteNode
        coin3 = childNode(withName: "coin3")as? SKSpriteNode
        
  
        
      //   coinBalance = userDefults.value(forKey: "bank")as! Int
        if let _coinbalance = userDefults.value(forKey: "bank")as? Int{
            coinBalance=_coinbalance
        }
        
        loadData()
    
        unlocked()
      
       
       
    }
    
    
    func unlocked(){
    //Character 2
    if let char2 = userDefults.value(forKey: "char2"){
        if (char2 as! Int == 1){
                bought2 = true;
            text2?.removeFromParent()
            coin2?.removeFromParent()
        }
        
        }
    
        //Character 3
        if let char2 = userDefults.value(forKey: "char3"){
            if (char2 as! Int == 1){
                bought3 = true;
                text3?.removeFromParent()
                coin3?.removeFromParent()
            }
            
        }
    
    }
    
    
    func bank(price :Int){
    
      
        if let currentfunds = userDefults.value(forKey: "bank"){
        
        coinBalance = (currentfunds as? Int)!  - price
        
        }
        userDefults.set(coinBalance, forKey: "bank")

        
    
    
    
    
    }
    
    
    func loadData(){
        
        if let charSelect = userDefults.value(forKey: "Character"){
            
            switch(charSelect as! Int){
            case 0:
                square1?.texture = SKTexture(imageNamed:"BlueSquare")
                square2?.texture = SKTexture(imageNamed:"square")
                square3?.texture = SKTexture(imageNamed:"square")
                
                break
            case 1:
                square2?.texture = SKTexture(imageNamed:"BlueSquare")
                square1?.texture = SKTexture(imageNamed:"square")
                square3?.texture = SKTexture(imageNamed:"square")

                break
            case 2:
                square3?.texture = SKTexture(imageNamed:"BlueSquare")
                square2?.texture = SKTexture(imageNamed:"square")
                square1?.texture = SKTexture(imageNamed:"square")

                break
            default:
                square1?.texture = SKTexture(imageNamed:"BlueSquare")
                square2?.texture = SKTexture(imageNamed:"square")
                square3?.texture = SKTexture(imageNamed:"square")
                
                break
                
            }
            
        }
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

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            
            if let touch = touches.first {
                start = (touch.location(in:self), touch.timestamp)
            }
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Back"{
                // bannerView.removeFromSuperview()
                if let scene = MenuScene(fileNamed:"MenuScene"){ //Sets Scene to the Menu Scene
                    
                    scene.scaleMode = .aspectFill;
                    view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1)) //Begins a transiton Animation
                    
                }
                
                
                
            }
        
       
            
            if atPoint(location).name == "Square1"{
     userDefults.set(0, forKey: "Character")
                print("Character 1 Selected")
                square1?.texture = SKTexture(imageNamed:"BlueSquare")
                square2?.texture = SKTexture(imageNamed:"square")
                square3?.texture = SKTexture(imageNamed:"square")
         
                
                
            }
            if (coinBalance > 199||bought2){
            
            if atPoint(location).name == "square2"{
                   print("Character 2 Selected")
                userDefults.set(1, forKey: "Character")
                square2?.texture = SKTexture(imageNamed:"BlueSquare")
                square1?.texture = SKTexture(imageNamed:"square")
                square3?.texture = SKTexture(imageNamed:"square")
                if(!bought2){
                    
                    bank(price: 200)
                    //coinBalance = coinBalance - 200;
                    balanceTxt?.text = "Balance: $\(coinBalance)"
                    text2?.removeFromParent()
                    coin2?.removeFromParent()
                    userDefults.set(1, forKey: "char2")
                  
                }
                
                bought2 = true;
                
                
                
                }
            }
            if (coinBalance > 299||bought3){
            if atPoint(location).name == "Square3"{
                
                
                userDefults.set(2, forKey: "Character")
                square3?.texture = SKTexture(imageNamed:"BlueSquare")
                square2?.texture = SKTexture(imageNamed:"square")
                square1?.texture = SKTexture(imageNamed:"square")
                if(!bought3){
                    
                    
                    bank(price: 300)
                    //coinBalance = coinBalance - 300;
                    balanceTxt?.text = "Balance: $\(coinBalance)"
                    coin3?.removeFromParent()
                    text3?.removeFromParent()
                    userDefults.set(1, forKey: "char3")
                }
                
                bought3 = true;
                }
            
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
