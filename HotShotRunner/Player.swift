//
//  Player.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 3/23/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit


class Player : SKSpriteNode{
    
    let userDefults = UserDefaults.standard
    
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    var TextureAtlasRun = SKTextureAtlas()
    var TextureArrayRun = [SKTexture]()
    
    var TextureAtlasGlide = SKTextureAtlas()
    var TextureArrayGlide = [SKTexture]()
    
    
    var whichCharacter = 0;
    
    
    
    func initilize(){
      //okay so lets first find out which character were using .
        
        if let CharSelect = userDefults.value(forKey: "Character"){
            if CharSelect as? Int == nil{
                whichCharacter = 0
            }else{
                whichCharacter = (CharSelect as? Int)!
            }
        }

        //Now lets determing what sprite where using 
        
        
        switch(whichCharacter){
        case 0: self.anchorPoint.y = 0.4;
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (90),height: (140)))
            break;
        case 1: self.anchorPoint.y = 0.4;
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (90),height: (140)))
            break;
        case 2:
            self.anchorPoint.y = 0.55;
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (90),height: (130)))
        
            break;
        
        default:
             self.anchorPoint.y = 0.4;
            self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (90),height: (140)))
            break;
        }
        
        
        
        
        
        
        
        
        
        
        
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.restitution = 0;
        self.physicsBody?.categoryBitMask = ColliderTypes.player;
        self.physicsBody?.contactTestBitMask = ColliderTypes.spikePlatforms + ColliderTypes.platforms;
        
        self.physicsBody?.collisionBitMask = ColliderTypes.platforms;
        
        
        loadIdleAnimation()
        loadRunAnimation()
        loadGlideAnimation()
    }
    
    
    func loadIdleAnimation(){
        
        
        
        switch(whichCharacter){
            
        case 0:    TextureAtlas = SKTextureAtlas(named: "Sprite1-Idle")
        
        for i in 0...9{
            
            let name = "Char1-Idle_00\(i).png"
            print(i)
            
            TextureArray.append(SKTexture(imageNamed: name))
        }
        
            break
        case 1: TextureAtlas = SKTextureAtlas(named: "Sprite2-Idle")
        
        for i in 0...9{
            
            let name = "Idle_00\(i).png"
            print(i)
            
            TextureArray.append(SKTexture(imageNamed: name))
        }
        
            break
        case 2:
            TextureAtlas = SKTextureAtlas(named: "Sprite3-Idle")
            
            for i in 1...9{
                
                let name = "Idle (\(i)).png"
                print(i)
                
                TextureArray.append(SKTexture(imageNamed: name))
            }
            
            
            break
        default: print("")
            break
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    func loadRunAnimation(){
        
        switch(whichCharacter){
            
        case 0:
            TextureAtlasRun = SKTextureAtlas(named: "Sprite1-Run")
            
            for i in 0...7{
                
                let name = "Char1-Run_00\(i).png"
                
                
                TextureArrayRun.append(SKTexture(imageNamed: name))
            }
            
            break
        case 1: TextureAtlasRun = SKTextureAtlas(named: "Sprite2-Run")
        
        for i in 1...7{
            
            let runName = "Run_00\(i).png";
            TextureArrayRun.append(SKTexture(imageNamed:runName));
        }
        
            break
        case 2:
            TextureAtlasRun = SKTextureAtlas(named: "Sprite3-Run")
            
            for i in 1...7{
                
                let name = "Run (\(i)).png"
                
                
                TextureArrayRun.append(SKTexture(imageNamed: name))
                
            }
            
            break
        default: print("")
            break
            
            
            
            
        }
        
        
    }
    
    func loadGlideAnimation(){
        
        TextureAtlasGlide = SKTextureAtlas(named: "Sprite3-Glide")
        
        for i in 1...9{
            
            let name = "Glide (\(i)).png"
            
            
            TextureArrayGlide.append(SKTexture(imageNamed: name))
        }
        
        
    }
    
    func runIdle(){
        
        
        self.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1, resize: true, restore: false)))
        
        
    }
    
    
    func runRun(){
        self.run(SKAction.repeatForever(SKAction.animate(with: TextureArrayRun, timePerFrame: 0.1, resize: true, restore: false)))
        
        
    }
    
    func runGlide(){
        
        self.run(SKAction.repeatForever(SKAction.animate(with: TextureArrayGlide, timePerFrame: 0.1, resize: true, restore: false)))
        
    }
    
    
    func move(moveLeft:Bool,speed:CGFloat){
        
        
        if moveLeft{
            self.position.x = self.position.x - speed;
            self.xScale = -fabs(self.xScale)
            
        }else{
            self.position.x = self.position.x + speed;
            self.xScale =
                fabs(self.xScale)
        }
        
        
    }
    
    
    
    
    
    
    
}




