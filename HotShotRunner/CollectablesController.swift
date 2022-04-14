//
//  CollectablesController.swift
//  StopDropRun
//
//  Created by Tyler Makhoul on 5/3/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit

class CollectablesController{

   

    func getCollectable() -> SKSpriteNode {
    
    
    
        var collectable = SKSpriteNode();
        
        
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4{
        
            collectable = SKSpriteNode(imageNamed:"Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            collectable.physicsBody?.affectedByGravity = false
            collectable.physicsBody?.categoryBitMask = 2
            collectable.physicsBody?.collisionBitMask = 0
            collectable.zPosition = 2
            collectable.xScale = 0.3;
            collectable.yScale = 0.3;
        }
        
        
        
        
        
        
        return collectable
    }
    
    
    func getDarkCoin() -> SKSpriteNode {
        
        
        
        var collectable = SKSpriteNode();
        
        
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 9{
            
            collectable = SKSpriteNode(imageNamed:"DarkModeCoin")
            collectable.name = "darkModeCoin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            collectable.physicsBody?.affectedByGravity = false
            collectable.physicsBody?.categoryBitMask = 2
            collectable.physicsBody?.collisionBitMask = 0
            collectable.zPosition = 2
         
        }
        
        
        
        
        
        
        return collectable
    }
    
    
    
    
    func getGlideCoin() -> SKSpriteNode{
    
        
        var collectable = SKSpriteNode();
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 9{
            
            collectable = SKSpriteNode(imageNamed:"GlideCoin2")
            collectable.name = "GlideCoin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            collectable.physicsBody?.affectedByGravity = false
            collectable.physicsBody?.categoryBitMask = 2
            collectable.physicsBody?.collisionBitMask = 0
            collectable.zPosition = 2
            
        }
        
    
    
        
        return collectable
    }
    
    
    func getStarCoin() -> SKSpriteNode{
        
        
        var collectable = SKSpriteNode();
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 9{
            
            collectable = SKSpriteNode(imageNamed:"starCoin")
            collectable.name = "starCoin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
            collectable.physicsBody?.affectedByGravity = false
            collectable.physicsBody?.categoryBitMask = 2
            collectable.physicsBody?.collisionBitMask = 0
            collectable.zPosition = 2
               }
        
        
        
        
        return collectable
    }


    
    
    func randomBetweenNumbers(firstNum:CGFloat ,secondNum:CGFloat)->CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
        
    }

}
