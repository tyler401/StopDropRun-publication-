//
//  GameViewController.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 3/17/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {


    @IBOutlet weak var AdView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
      

        if let view = self.view as! SKView? {
          
          //Gesture code
           
        
            
            //end of ges
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = MenuScene(fileNamed: "MenuScene") {
                
                if let Gamescene = GameSceneClass(fileNamed: "GameScene") {
                    
                    Gamescene.viewController = self
                }

                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            
          //  view.ignoresSiblingOrder = true
             view.showsPhysics = true;
            
            
           view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
