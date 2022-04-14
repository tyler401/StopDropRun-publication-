//
//  BGclass.swift
//  StopDropRun
//
//  Created by Tyler Makhoul on 5/14/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit

class BGclass: SKSpriteNode{

    func moveBackground(camera :SKCameraNode){
        
        if (self.position.y - self.size.height  > camera.position.y ) {
            
            self.position.y -= (self.size.height * 3) - 120
            ;
            
        }
        
    
    }
    


}
