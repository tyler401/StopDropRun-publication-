//
//  Platforms.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 3/31/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit


struct ColliderTypes{
    static let player:UInt32 = 0;
    static let platforms:UInt32 = 1;
    static let spikePlatforms:UInt32 = 2;
    
    
}



class Platforms:SKSpriteNode{
    
    var CharacterAbility = 2
    
    
    
    let collectableController = CollectablesController()
    
    var  Platform1 :SKSpriteNode?
    
    var lastPlatformPositionY = CGFloat();
    
    
    func randomBetweenNumbers(firstNum:CGFloat ,secondNum:CGFloat)->CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
        
    }
    
    func shuffle( PlatformsArray:inout [SKSpriteNode]) {
        
        for i in (1..<PlatformsArray.count).reversed() {
            
            let j:Int = Int(arc4random_uniform(UInt32(i - 1)))
            
            
            
            PlatformsArray.swapAt(i, j)
            
        }
        
    }
    
    
    
    func createPlatforms() -> [SKSpriteNode]{ //Function Returns array of spriteKitNodes
        
        
        
        var Platforms = [SKSpriteNode]();
        
        for _ in 0 ..< 2 {
            
            
            
            
            let Platform1 = SKSpriteNode(imageNamed: "Platform 1")
            Platform1.name = "plat"                                       //A name to use to remove the Platform from memmory once it leaves the scene
            let Platform2 = SKSpriteNode(imageNamed: "Platform 2")
            Platform2.name = "plat"
            let Platform3 = SKSpriteNode(imageNamed: "Platform 3")
            Platform3.name = "plat"
            let DarkPlatform1 = SKSpriteNode(imageNamed: "DeathPlat")
            DarkPlatform1.name = "Spike"
            
            let Platform4 = SKSpriteNode(imageNamed: "Platform 4")
            Platform4.name = "plat"
            
            
            
            
            Platform1.xScale = 2.0
            Platform1.yScale = 0.9
            Platform1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:Platform1.size.width,height:Platform1.size.height))
            Platform1.physicsBody?.isDynamic = false
            Platform1.physicsBody?.restitution = 0
            Platform1.physicsBody?.categoryBitMask = ColliderTypes.platforms
            
            Platform2.xScale = 2.0
            Platform2.yScale = 0.9
            
            Platform2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:Platform1.size.width,height:Platform1.size.height))
            Platform2.physicsBody?.isDynamic = false
            Platform2.physicsBody?.restitution = 0
            Platform2.physicsBody?.categoryBitMask = ColliderTypes.platforms
            
            Platform3.xScale = 2.0
            Platform3.yScale = 0.9
            
            Platform3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:Platform1.size.width,height:Platform1.size.height))
            Platform3.physicsBody?.isDynamic = false
            Platform3.physicsBody?.restitution = 0
            Platform3.physicsBody?.categoryBitMask = ColliderTypes.platforms
            
            
            //game
            
            
            
            DarkPlatform1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:DarkPlatform1.size.width,height:DarkPlatform1.size.height))
            DarkPlatform1.physicsBody?.isDynamic = false;
            DarkPlatform1.xScale = 1.5
            DarkPlatform1.yScale = 0.9
            //  DarkPlatform1.alpha = 0.4
            
            
            
            DarkPlatform1.physicsBody?.categoryBitMask = ColliderTypes.spikePlatforms;
            DarkPlatform1.physicsBody?.contactTestBitMask = ColliderTypes.player;
            DarkPlatform1.physicsBody?.collisionBitMask = ColliderTypes.player;
            
            
            //New Platform purple
            
            Platform4.xScale = 2.0
            Platform4.yScale = 0.9
            
            Platform4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:Platform1.size.width,height:Platform1.size.height))
            Platform4.physicsBody?.isDynamic = false
            Platform4.physicsBody?.restitution = 0
            Platform4.physicsBody?.categoryBitMask = ColliderTypes.platforms
            
            
            
            
            //Need to add physics bodys to these Platforms
            
            Platforms.append(Platform1) //
            Platforms.append(Platform2)
            Platforms.append(Platform3)
            Platforms.append(DarkPlatform1)
            Platforms.append(Platform4)
            
        }
        
        shuffle(PlatformsArray: &Platforms)
        return Platforms;
        
    }
    
    func removeThemDarkCoin(){
        
        
        
        
    }
    
    
    func arrangePlatformsInScene( Scene: SKScene, distanceBetweenPlatforms : CGFloat, center: CGFloat, minX:CGFloat, maxX :CGFloat, inintalPlatforms :Bool,specialCoin:Int){
        
        
        
        
        var Platforms = createPlatforms()
        
        if inintalPlatforms{
            while(Platforms[0].name=="Spike"){
                //Add a shuffle Platform Array function
                shuffle(PlatformsArray: &Platforms)
            }
            
        }
        
        
        
        if(Platforms[0].name=="Spike" && Platforms[1].name=="Spike" ){
            shuffle(PlatformsArray: &Platforms)
            
            
        }
        
        var positionY = CGFloat()
        
        if inintalPlatforms{
            positionY = center - 100
        }else{
            positionY = lastPlatformPositionY
        }
        
        var random = 0;
        
        for i in 0...Platforms.count - 1{
            
            
            
            
            
            
            
            var randomX = CGFloat();
            
            if(random==0){
                randomX = randomBetweenNumbers(firstNum: center+90, secondNum: maxX)
                random = 1;
            }else if random == 1{
                randomX = randomBetweenNumbers(firstNum: center-90, secondNum: minX)
                random = 0
                
                
            }
            
            
            Platforms[i].position = CGPoint(x:randomX,y:positionY);
            Platforms[i].zPosition = 3;
            
            if(!inintalPlatforms){
                if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 3 {
                    
                    if (Platforms[i].name != "Spike"){
                        let collectable = collectableController.getCollectable()
                        collectable.position = CGPoint(x: Platforms[i].position.x, y: Platforms[i].position.y + 90)
                        
                        Scene.addChild(collectable)
                        
                        
                    }
                    //Dark Coin Charcter ninja Specific
                    if (Platforms[i].name != "Spike" && specialCoin == 1){
                        let Darkcollectable = collectableController.getDarkCoin()
                        Darkcollectable.position = CGPoint(x: Platforms[i].position.x, y: Platforms[i].position.y + 90)
                        
                        Scene.addChild(Darkcollectable)
                        
                        
                    }
                    
                    //
                    if (Platforms[i].name != "Spike" && specialCoin == 2){
                        let GlideCoin = collectableController.getGlideCoin()
                        GlideCoin.position = CGPoint(x: Platforms[i].position.x, y: Platforms[i].position.y + 90)
                        
                        Scene.addChild(GlideCoin)
                        
                        
                    }
                    
                    
                    if (Platforms[i].name != "Spike" && specialCoin == 0){
                        let _starCoin = collectableController.getStarCoin()
                        _starCoin.position = CGPoint(x: Platforms[i].position.x, y: Platforms[i].position.y + 90)
                        
                        Scene.addChild(_starCoin)
                        
                        
                    }

                    
                    
                }
                
                
            }
            
            
            Scene.addChild(Platforms[i])
            positionY -= distanceBetweenPlatforms;
            lastPlatformPositionY = positionY;
        }
        
    }
    
    
}
