//
//  GameSceneClass.swift
//  HotShotRunner
//
//  Created by Tyler Makhoul on 3/22/17.
//  Copyright © 2017 Makhoul. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GoogleMobileAds


class GameSceneClass: SKScene , SKPhysicsContactDelegate{
    
    //Initial Variables
    var player :Player?
    var platform:SKSpriteNode?
    var particle = Particle()
    
    var gameView = GameViewController()
    var coinBalance = 0
    var CanMove = false;
    var Center :CGFloat?
    var moveLeft = false
    
    var Maincamera :SKCameraNode?
    
    
    
    var pauseButton :SKSpriteNode?
    
    var scoreLabel :SKLabelNode?
    
    var wall1 :SKSpriteNode?
    var wall2 :SKSpriteNode?
    
    var distanceBetweenClouds = CGFloat(440);
    
    let minX = CGFloat (-325)
    let maxX = CGFloat(325)
    
    
    var plat = Platforms();
    
    var spawnWhenfar = CGFloat()
    
    var cameraSpeed = CGFloat()
    
    var camScroll = true;
    
    var ScoreCounter = CGFloat();
    
    var scoreNum = 0;
    
    var CanPlayDead = false
    
    var Alive = true;
    
    let userDefults = UserDefaults.standard
    
    private var PausePanel :SKSpriteNode?
    
    private var ScorePanel :SKSpriteNode?
    
    private var whatsTheDifficulty = 0;
    
    var maxCameraSpeed :CGFloat?
    
    var ScoreSpace :CGFloat?
    
    
    var oldScore = 0 ;
    
    let coinSound = SKAction.playSoundFileNamed("point.mp3", waitForCompletion: false)
    let deathSound = SKAction.playSoundFileNamed("Fall.wav", waitForCompletion:false)
    
    var viewController: GameViewController!
    var bannerView: GADBannerView!
    
    var coinLabel :SKLabelNode?
    
    var playedBefore = 0;
    
    var coinValue = 500; //Change this value before release.
    
    
    var mute = 0;
    
    var bg1 :BGclass?
    var bg2 :BGclass?
    var bg3 :BGclass?
    
    var bg4 :BGclass?
    
    
    
    var flash : SKSpriteNode?
    
    var lightMode = false;
    
    var Playerspeed = 15;
    
    var specialCoin = 0;
    
    var starMode = false;
    
    var glideOn = false;
    
    var grounded = false;
    
    
    
    
    //First Method to run
    override func didMove(to view: SKView) {
        
        handleDifficulty()
        
        start()
        
        if bannerView == nil {
            //  initializeBanner()
        }
        loadRequest()
    }
    /////////////////////////////////Advertisement Init
    
    func initializeBanner() {
         //Create a banner ad and add it to the view hierarchy.
        //bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
       // bannerView.adUnitID = "ca-app-pub-3872909569931273/2913364344"
        //bannerView.rootViewController = gameView.self
        
       // view!.addSubview(bannerView)
    }
    
    
    func loadRequest() {
       //  let request = GADRequest()
      //      request.testDevices = [kGADSimulatorID,kGADAdSizeSmartBannerPortrait]
         //   bannerView.load(request)
    }
    
    ////Difficulty loader.
    
    func handleDifficulty(){
        
        if let difficulty = userDefults.value(forKey: "Difficulty"){
            whatsTheDifficulty = difficulty as! Int
            
            switch(whatsTheDifficulty){
                
            case 0:   if let Highscore = userDefults.value(forKey: "highScore") { //Returns the integer value associated with the specified key.
                oldScore = Highscore as! Int; }
            distanceBetweenClouds = CGFloat(340);
            maxCameraSpeed = 1
            ScoreSpace = 680;
            
                break
            case 1:if let Highscore = userDefults.value(forKey: "highScoreMedium") { //Returns the integer value associated with the specified key.
                oldScore = Highscore as! Int; }
            distanceBetweenClouds = CGFloat(440);
            maxCameraSpeed = 14
            ScoreSpace = 880;
            
            
                break
            case 2:if let Highscore = userDefults.value(forKey: "highScoreHard") { //Returns the integer value associated with the specified key.
                oldScore = Highscore as! Int; }
            distanceBetweenClouds = CGFloat(540);
            maxCameraSpeed = 16
            ScoreSpace = 1080;
            
            
                break
                
            default:if let Highscore = userDefults.value(forKey: "highScore") { //Returns the integer value associated with the specified key.
                oldScore = Highscore as! Int; }
            
            distanceBetweenClouds = CGFloat(340);
            maxCameraSpeed = 1
            ScoreSpace = 680;
            
            
            
            break;
            }
            
            
        }
        
        
    }
    
    ///////////////////////////////////////////////////Start Function
    func start(){
        
        //Fix this shit
        
        //add if mute is not nil
        
        
        
        if let _mute = userDefults.value(forKey: "Mute"){
            mute = (_mute as? Int)!
            
            
        }
        
        
        //same here
        
        if let _coinBalance = userDefults.value(forKey: "bank"){
            coinBalance = (_coinBalance as? Int)!
            
        }
        
        
    
        
        if(coinBalance < coinValue){
            userDefults.set(0, forKey: "bank")
            print("Less than 10 ")
        }
        ////////////////////////////////////
        
        
        
        //      pointSound  = childNode(withName: "point.mp3")as? SKAudioNode
        
        coinLabel = childNode(withName:"coinLabel")as? SKLabelNode
        
        NSLog("Loading ininital varibales")
        CanPlayDead = true;
        cameraSpeed = 5;
        self.physicsWorld.contactDelegate = self
        
        player = childNode(withName: "Player")as? Player
        Center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        scoreLabel = childNode(withName: "Score")as? SKLabelNode
        player?.initilize();
        
        
        platform = childNode(withName: "Platforms")as? SKSpriteNode
        
        platform?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (platform?.size.width)!,height: (platform?.size.height)!))
        
        platform?.physicsBody?.isDynamic = false;
        
        Maincamera = childNode(withName: "Camera")as? SKCameraNode
        
        
        pauseButton = childNode(withName: "Pause")as? SKSpriteNode
        
        wall1 = childNode(withName: "Wall1")as? SKSpriteNode
        wall2 = childNode(withName: "Wall2")as? SKSpriteNode
        plat.arrangePlatformsInScene(Scene: self.scene!, distanceBetweenPlatforms: distanceBetweenClouds, center: Center!, minX: minX, maxX: maxX, inintalPlatforms : true, specialCoin: specialCoin)
        
        spawnWhenfar = (Maincamera?.position.y)! - 400;
        
        ScoreCounter = Center! - CGFloat(100);
        
        ScoreCounter = ScoreCounter - ScoreSpace!;
        
        player?.runIdle();
        wallet()
        
        
        //Check if the bank is empty if so set the value to 0 else retrive the value that is stored.
        if let _bank = userDefults.value(forKey: "bank"){
            if _bank as? Int == nil {
                
                userDefults.set(0, forKey: "bank")
            }
            
            
        }
        
        getBackGrounds()
        
        
        //initilize flash animation
        
        flash = childNode(withName: "Flash")as? SKSpriteNode
        
        
        flash?.alpha = 0
        
        
        specialCoin = (player?.whichCharacter)!
        
        
        
    }
    
    
    
    /////////////////////////////////////////////////////////////Update method called once per frame
    override func update(_ currentTime: TimeInterval) {
        MovePlayer()
        makeMorePlats()
        moveCamera()
        score()
        checkBounds()
        checkForItemsOutOfScreen()
        manageBackgrounds()
        
        
        
    }
    
    
    
    func getBackGrounds(){
        bg1 = (self.childNode(withName: "BG 1")as? BGclass?)!
        bg2 = (self.childNode(withName: "BG 2")as? BGclass?)!
        bg3 = (self.childNode(withName: "BG 3")as? BGclass?)!
    }
    
    
    

    
    //////////////////////////////////////////////////////////Contact end and begin functions.
    func didEnd(_ contact: SKPhysicsContact) {
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "plat"){
            
            grounded = false;
            
        }
        
    }
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {                                       //Collision Between two objects.
        
        //Collision between Player And Sprite
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Spike"){
            
            if(!starMode){
                NSLog("Player Died")
                die();
                
            }else{
                contact.bodyB.node?.removeFromParent()
            }
            
        }
        
        
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "plat"){
            print("plat")
            
            grounded = true;
            
            
            
        }
        
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "Coin"){
            print("Got A COin")
            
            contact.bodyB.node?.removeFromParent()
            
            if let currentfunds = userDefults.value(forKey: "bank"){
                
                coinBalance = (currentfunds as? Int)! + coinValue
                
            }
            userDefults.set(coinBalance, forKey: "bank")
            
            wallet()
        }
        
        
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "darkModeCoin"){
            print("dark coin collected")
            if(!lightMode){
                flashWhite() }else{
                //Already in LightMode so running collectable as double coin
                
                if let currentfunds = userDefults.value(forKey: "bank"){
                    
                    coinBalance = (currentfunds as? Int)! + (coinValue*2)
                    
                }
                userDefults.set(coinBalance, forKey: "bank")
                
                wallet()
                
            }
            contact.bodyB.node?.removeFromParent()
        }
        
        //Glide Coin Contact
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "GlideCoin"){
            
            glideTime()
            
            contact.bodyB.node?.removeFromParent()
        }
        
        //Star Coin Contact
        if(contact.bodyA.node?.name == "Player" && contact.bodyB.node?.name == "starCoin"){
            
            
            contact.bodyB.node?.removeFromParent()
            _starMode()
        }
        
        
        
    }
    
    
    
    
    
    /////////////////////////////////////// Touch interaction Methods.
    
    
    
    
    //Method called when Finger is removed from screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        CanMove=false; // Variable is swithced to false to stop the player from moving when finger is removed from screen.
        player?.runIdle()
        
        
    }
    
    
    //Method is called when the finger is moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
           animationHandler()
        
        for touch in touches{
            
            
            let location = touch.location(in: self) // variable location is set to the postion of the finger
            
            //Direction Detection
            
            if location.x < Center!{ // Move Left
                moveLeft=true
                CanMove=true
                
            }else{                  //Moves Right
                
                moveLeft=false
                CanMove=true
            }
            
            
        }
    }
    
    
    
    
    
    
    
    
    //method is called when finger is placed.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
           animationHandler()
        
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            
            //Direction Detection
            
            if location.x < Center!{ //Moves Left
                moveLeft=true
                CanMove=true
                
            }else{
                
                moveLeft=false      //Moves Right
                CanMove=true
            }
            
            
            //Play Button
            if atPoint(location).name == "quit"{
                // bannerView.removeFromSuperview()
                PausePanel?.removeFromParent()
                if let scene = MenuScene(fileNamed:"MenuScene"){ //Sets Scene to the Menu Scene
                    
                    scene.scaleMode = .aspectFill;
                    view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1)) //Begins a transiton Animation
                    
                }
                
            }
            
            if atPoint(location).name == "Pause" {
                
                if Alive && (self.scene?.isPaused)! == false {
                    self.scene?.isPaused = true;
                    createPauseMenu()
                }
            }
            
            
            if atPoint(location).name == "Resume" {
                PausePanel?.run(SKAction.fadeOut(withDuration: 1))
                PausePanel?.removeFromParent()
                self.scene?.isPaused = false;
                
                
                
            }
            
            if atPoint(location).name == "replay" {
                //  bannerView.removeFromSuperview()
                reSpawn()
                
            }
            
            
            
            
            
            
        }
    }
    
    
    /////////////////////  //Method to handle the player movement
    func MovePlayer(){
        player?.zRotation = 0;
        
        
        
        if CanMove{
            
            player?.move(moveLeft: moveLeft,speed:CGFloat(Playerspeed))
            
        }else{
            
        }
        
        
        
        
    }
    
    ////////////////////////Camera Movement
    func moveCamera(){
        if camScroll{
            if cameraSpeed < maxCameraSpeed! {
               
                cameraSpeed = cameraSpeed * 1.0003;
            }
            
            Maincamera?.position.y -= cameraSpeed;
            coinLabel?.position.y -= cameraSpeed;
            scoreLabel?.position.y -= cameraSpeed;
            scoreLabel?.zPosition = 5;
            flash?.position.y -= cameraSpeed;
            
            
        }
    }
    
    
    //Generate more platforms //This method is dependent on the platforms class
    
    func makeMorePlats(){
        
        if (Maincamera?.position.y)! < spawnWhenfar{
            plat.arrangePlatformsInScene(Scene: self.scene!, distanceBetweenPlatforms: distanceBetweenClouds, center: Center!, minX: minX, maxX: maxX, inintalPlatforms : false,specialCoin:specialCoin)
            NSLog("Made More Plaforms")
            spawnWhenfar = (Maincamera?.position.y)! - 2400;
        }
        
        
    }
    
    
    
    //Determine when to remove items from the game world
    
    func checkForItemsOutOfScreen(){
        
        for child in children{
            
            if child.position.y > (Maincamera?.position.y)! + (self.scene?.size.height)!{
                
                let childName = child.name?.components(separatedBy: " ");
                
                
                if childName?[0] != "BG" && childName?[0] !=  "Player" {
                    
                    child.removeFromParent()
                    
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
    //The method to reload and reset the scene after the player dies.
    func reSpawn(){
        
        if let scene = GameSceneClass(fileNamed:"GameScene"){ //Sets Scene to the Menu Scene
            scene.scaleMode = .aspectFill;
            view?.presentScene(scene, transition: SKTransition.fade(withDuration: 1)) //Begins a transiton Animation
            NSLog("Re Spawing Player")
        }
        
    }
    
    
    //Checks that the player maintains inside the game screen.
    
    func checkBounds(){
        if((player?.position.y)! > ((camera?.position.y)!+660)){
            
            die()
        }
        if((player?.position.y)! < ((camera?.position.y)!-710)){
            die()
            
        }
        
    }
    
    
    func score(){
        
        if((player?.position.y)! < ScoreCounter){
            
            //add one to score;
            scoreNum += 1;
            scoreLabel?.text = ("\(scoreNum)")
            scoreLabel?.fontSize = 56;
            
            //Play Sound;
            
            
            if(mute == 1){
                player?.run(coinSound);
            }
            
            
            
            
            ScoreCounter = ScoreCounter - ScoreSpace!;
            
            
        }
        
        
    }
    
    
    
    
    
    func die(){
        if CanPlayDead && !starMode{
            CanPlayDead = false
            Alive = false;
            
            //death particles
            particle.spawnParticlesDeath(scene: self.scene!, xpos: (player?.position.x)!, ypos: (player?.position.y)!)
            //stop the camera
            camScroll = false;
            cameraSpeed = 0;
            //Remove the player
            
            player?.removeFromParent()
            
            //play Sound
            //   camera?.run(deathSound)
            
            
            if(mute == 1){
                camera?.run(deathSound);
            }
            
            //Present HighScore / Score
            
            
            //pause game for 3 second
            let delay = SKAction.wait(forDuration: 1.5)
            camera?.run(delay) {
                //Restart
                //   self.reSpawn()
                self.createScorePanel()
            }
            
        }
    }
    
    
    ///////////Menu GUI functions
    
    func createPauseMenu(){
        
        PausePanel = SKSpriteNode(imageNamed: "PausePanel")
        let resumeButton = SKSpriteNode(imageNamed: "ResumeButton")
        let quitButton = SKSpriteNode(imageNamed: "QuitButton")
        
        PausePanel?.anchorPoint = CGPoint(x:0.5,y:0.5);
        PausePanel?.xScale = 2.0
        PausePanel?.yScale = 2.0;
        PausePanel?.zPosition = 4;
        PausePanel?.position = CGPoint(x: (self.Maincamera?.frame.size.width)! / 2,y:(self.Maincamera?.frame.height)!/2)
        
        
        resumeButton.name = "Resume";
        resumeButton.zPosition = 5;
        resumeButton.anchorPoint = CGPoint(x:0.5,y:0.5);
        resumeButton.position = CGPoint(x:(PausePanel?.position.x)!,y:(PausePanel?.position.y)!+25)
        
        
        quitButton.name = "quit"
        quitButton.zPosition = 5;
        quitButton.anchorPoint = CGPoint(x:0.5,y:0.5);
        quitButton.position = CGPoint(x:(PausePanel?.position.x)!,y:(PausePanel?.position.y)! - 45)
        
        PausePanel?.addChild(resumeButton)
        PausePanel?.addChild(quitButton)
        
        
        self.Maincamera?.addChild(PausePanel!)
        PausePanel?.run(SKAction.fadeIn(withDuration: 1))
        
    }
    
    
    func saveTheScore(){
        
        switch(whatsTheDifficulty){
            
        case 0: userDefults.set(scoreNum, forKey: "highScore")
            break
        case 1: userDefults.set(scoreNum, forKey: "highScoreMedium")
            break
        case 2: userDefults.set(scoreNum, forKey: "highScoreHard")
            break
            
        default: userDefults.set(scoreNum, forKey: "highScore")
        break;
        }
        
        
        
    }
    
    
    
    func createScorePanel(){
        
        //Save the Score
        
        
        
        if(scoreNum > oldScore){
            saveTheScore()
            oldScore = scoreNum
        }
        //
        
        scoreLabel?.removeFromParent()
        
        ScorePanel = SKSpriteNode(imageNamed: "Panel")
        let exitButton = SKSpriteNode(imageNamed: "ExitButton")
        let rePlayButton = SKSpriteNode(imageNamed: "RefreshButton")
        let currentScore = SKLabelNode();
        let HighScore = SKLabelNode();
        
        ScorePanel?.anchorPoint  = CGPoint(x:0.5,y:0.5);
        ScorePanel?.xScale = 2.0;
        ScorePanel?.yScale = 2.0;
        ScorePanel?.zPosition  = 5;
        ScorePanel?.position = CGPoint(x: (self.Maincamera?.frame.size.width)! / 2,y:(self.Maincamera?.frame.height)!/2)
        
        rePlayButton.name = "replay";
        rePlayButton.zPosition = 6;
        rePlayButton.anchorPoint = CGPoint(x:0.5,y:0.5);
        rePlayButton.position = CGPoint(x:(ScorePanel?.position.x)! + 70,y:(ScorePanel?.position.y)! - 75)
        rePlayButton.xScale = 0.7;
        rePlayButton.yScale = 0.7;
        
        
        
        exitButton.name = "quit"
        exitButton.zPosition = 6;
        exitButton.anchorPoint = CGPoint(x:0.5,y:0.5);
        exitButton.position = CGPoint(x:(ScorePanel?.position.x)! - 70 ,y:(ScorePanel?.position.y)! - 75)
        exitButton.xScale = 0.7;
        exitButton.yScale = 0.7;
        
        currentScore.text = "Score: \(scoreNum)"
        currentScore.fontName = "Avenir Next";
        currentScore.color = UIColor.blue
        
        currentScore.position = CGPoint(x:(ScorePanel?.position.x)! ,y:(ScorePanel?.position.y)! + 75)
        
        HighScore.text = "HighScore: \(oldScore)"
        HighScore.fontName = "Avenir Next";
        HighScore.color = UIColor.blue
        
        HighScore.position = CGPoint(x:(ScorePanel?.position.x)! ,y:(ScorePanel?.position.y)! + 40)
        
        ScorePanel?.addChild(HighScore)
        ScorePanel?.addChild(currentScore)
        ScorePanel?.addChild(rePlayButton)
        ScorePanel?.addChild(exitButton)
        
        
        self.Maincamera?.addChild(ScorePanel!)
        ScorePanel?.run(SKAction.fadeIn(withDuration: 1))
        
    }
    
    
    
    ///The games money system functions.
    
    func wallet(){
        //Get the funds from saved data
        if let currentfunds = userDefults.value(forKey: "bank"){
            
            coinBalance = (currentfunds as? Int)!
            print(currentfunds)
        }
        
        coinLabel?.text = "\(coinBalance)"
        
        
    }
    
    func manageBackgrounds(){
        bg1?.moveBackground(camera: Maincamera!)
        bg2?.moveBackground(camera: Maincamera!)
        bg3?.moveBackground(camera: Maincamera!)
        
    }
    
    
    
    
    
    
     //////////Special ability functions .
    
    func flashWhite(){
        
        print("flashing white for 1 seconds")
        flash?.run(SKAction.sequence([
            SKAction.fadeAlpha(to: 1.00, duration: 0.75),
            SKAction.run({
                self.lightMode = true;
                self.Playerspeed = 25;
                
                //Change the background
                self.bg1?.texture = SKTexture(imageNamed: "BGW")
                self.bg2?.texture = SKTexture(imageNamed: "BGW")
                self.bg3?.texture = SKTexture(imageNamed: "BGW")
                
                
                
            }),
            SKAction.fadeOut(withDuration: 1),
            SKAction.wait(forDuration: 10),
            SKAction.fadeAlpha(to: 1.00, duration: 0.25),
            SKAction.fadeOut(withDuration: 0.1),
            SKAction.fadeAlpha(to: 1.00, duration: 0.25),
            SKAction.fadeOut(withDuration: 0.1),
            SKAction.fadeAlpha(to: 1.00, duration: 0.25),
            SKAction.fadeOut(withDuration: 0.1),
            SKAction.run {
                self.bg1?.texture = SKTexture(imageNamed: "BG")
                self.bg2?.texture = SKTexture(imageNamed: "BG")
                self.bg3?.texture = SKTexture(imageNamed: "BG")
                
                self.lightMode = false;
                self.Playerspeed = 15;
                
                
            }
            ]))
        
    }
    
    
    func glideTime(){
        
        
        
        player?.run(SKAction.sequence([
            SKAction.run({
                //                  Default     0.0    -9.8
                self.physicsWorld.gravity = CGVector(dx:0.0,dy:-5.0)
                self.cameraSpeed = 5;
                self.glideOn = true;
                
            }),SKAction.wait(forDuration: 15),SKAction.run({
                self.physicsWorld.gravity = CGVector(dx:0.0,dy:-9.8)
                self.cameraSpeed = 10;
                self.glideOn = false;
            })
            
            ]))
        
        
    }
    
    func _starMode(){
        
        
        
        player?.run(SKAction.sequence([SKAction.run({
            self.starMode = true;
            
            
        }),  SKAction.colorize(with: .yellow, colorBlendFactor: 0.8, duration: 0.25),
             SKAction.wait(forDuration: 7),
             SKAction.colorize(withColorBlendFactor: 0.0, duration: 3),
             SKAction.run({
                self.starMode=false;
           
             })]))
        
        
        
        
        
        
    }
    
    //animation determiner.
    
    
    func animationHandler(){
        
        if(grounded){
            
            player?.runRun();
        }
        if(grounded && glideOn){
            
            player?.runRun();
        }
        
        if(!grounded && glideOn){
            
            player?.runGlide();
        }
    
               
        
    }
    
    
    
    
}



