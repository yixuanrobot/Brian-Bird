//
//  GameplayScene.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/28/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate{

    var bird = Bird();
    
    var pipesHolder = SKNode();
    
    var scoreLabel = SKLabelNode(fontNamed: "04b_19")
    var score = 0;
    
    var gameStarted = false;
    var isAlive = false;
    
    var press = SKSpriteNode();
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isAlive { //if the game is active movebgsandgrounds
            moveBackgroundsAndGrounds();
        }
    }
    
    
    
    func initialize(){
        
        gameStarted = false; //re do this because he have inside the retry button
        isAlive = false;
        score = 0; //restart to 0 when retry button is zero.
        
        physicsWorld.contactDelegate = self
        
        createInstructions()
        createBird()
        createBackground();
        createGrounds();
       // spawnObstacles(); //create pipes is inside
        createLabel();
    }
    
    func createInstructions() {
        press = SKSpriteNode(imageNamed: "Press")
        press.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        press.position = CGPoint(x: 0, y: 0)
        press.setScale(1.8)
        press.zPosition = 10;
        self.addChild(press);
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //this is the first time we touch the screen
        if gameStarted == false {
            isAlive = true;
            gameStarted = true;
            press.removeFromParent() //does not show press instruction when it starts
            spawnObstacles();
            bird.physicsBody?.affectedByGravity = true;
            bird.flap();
        }
        
        if isAlive {
            bird.flap();
        }
        
        
        for touch in touches {
            let location = touch.location(in: self) // get location in node of the skscene self.
            
            if atPoint(location).name == "Retry"{
                // restart the game
                self.removeAllActions();
                self.removeAllChildren(); //remove every child node we have in our scene
                initialize();
            
            }
            
            if atPoint(location).name == "Quit" {
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene");
                mainMenu!.scaleMode = .aspectFill
                self.view?.presentScene(mainMenu!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
            }
            
        }
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Bird"{ //we named the node Bird because thats the bird.swift class how we named self.name check
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Bird" && secondBody.node?.name == "Score"{
            incrementScore()
        } else if firstBody.node?.name == "Bird" && secondBody.node?.name == "Pipe"{
            //collide with pipes so kill bird!!!!
            if isAlive { //IF BIRD IS ALIVE THEN CALL BIRDDIED
                birdDied();
            }
            
        } else if firstBody.node?.name == "Bird" && secondBody.node?.name == "Ground"{
            //kill the bird
            if isAlive {
                birdDied();
            }
            
            
        }
        
    }
    
    func createBird() {
        bird = Bird(imageNamed: "\(GameManager.instance.getBird()) 1");//we can use imagedName since Bird inherientence from skspritenode\
        bird.initalize();
        bird.position = CGPoint(x: -50, y: 0)
        self.addChild(bird)
    }
    
    func createBackground(){
        for i in 0...2{
            let bg = SKSpriteNode(imageNamed: "BG Day")
            bg.name = "BG";
            bg.zPosition = 0;
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            //first 0 * 750 =0, then 1 * 750 = 750... 750 is the bg width.
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width , y: 0)
            self.addChild(bg)
            
        }
    }
    
    func createGrounds() {
        for i in 0...2{
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground";
            ground.zPosition = 4;
            ground.anchorPoint = CGPoint(x:0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 2));
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.affectedByGravity = false;
            ground.physicsBody?.isDynamic = false; //this would mean that our ground is not going to be pushed down by other nodes collide so setting isDynamic false means its static
            ground.physicsBody?.categoryBitMask = ColliderType.Ground
            self.addChild(ground)
        }
    }
    
    func moveBackgroundsAndGrounds(){
         //this code will move every node that has the name BG by 4.5 to the left side
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.x -= 4.5;
            if node.position.x < -(self.frame.width){ //if the node of bg is out of scene
                node.position.x += self.frame.width * 3; //the node will re do for the scene can not go out of screen, we multiply by 3 because we have 3 bG's
            }
            
        }));
        //this code will move every node that has the name Ground by 4.5 to the left side
        enumerateChildNodes(withName: "Ground", using: ({
            (node, error) in
            
            node.position.x -= 2;
            if node.position.x < -(self.frame.width){ //if the node of gound is out of scene
                node.position.x += self.frame.width * 3; //the node will re do for the scene can not go out of screen, we multiply by 3 because we have 3 ground
            }
            
        }));
        
        
    }
    
    
    func createPipes() {
        pipesHolder = SKNode();
        pipesHolder.name = "Holder"
        
        let pipeUp = SKSpriteNode(imageNamed: "Pipe 1");
        let pipeDown = SKSpriteNode(imageNamed: "Pipe 1");
        
        //the gap between the pipes
        let scoreNode = SKSpriteNode();
        
        scoreNode.color = SKColor.red
        
        scoreNode.name = "Score";
        scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scoreNode.position = CGPoint(x: 0, y: 0)
        scoreNode.size = CGSize(width: 5, height: 300)// THE GAPS SIZE BETWEEN PUPES
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.categoryBitMask = ColliderType.Score;
        scoreNode.physicsBody?.collisionBitMask = 0 //we don't want score to collide with other objects
        scoreNode.physicsBody?.affectedByGravity = false;
        scoreNode.physicsBody?.isDynamic = false;
        
        pipeUp.name = "Pipe"
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeUp.position = CGPoint(x: 0, y: 630)
        pipeUp.yScale = 1.5;
        pipeUp.zRotation = CGFloat(M_PI); //rotate 180 degress
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeUp.physicsBody?.affectedByGravity = false;
        pipeUp.physicsBody?.isDynamic = false;//when the bird touches we do not want for the pipe to move
        
        pipeDown.name = "Pipe"
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeDown.position = CGPoint(x: 0, y: -630)//this make the gap between pipes
        pipeDown.yScale = 1.5;//pipes scale is larger
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeDown.physicsBody?.categoryBitMask = ColliderType.Pipes
        pipeDown.physicsBody?.affectedByGravity = false;
        pipeDown.physicsBody?.isDynamic = false;//when the bird touches we do not want for the pipe to move
        
        pipesHolder.zPosition = 5; //greater position of the ground
        pipesHolder.position.x = self.frame.width + 100; //whole scene plus 100px which so thats spawing pipes on the right side where the player can not see it
        pipesHolder.position.y = CGFloat.randomBetweenNumbers(firstNum: -300, secondNum: 300)
        
        pipesHolder.addChild(pipeUp);
        pipesHolder.addChild(pipeDown);
        pipesHolder.addChild(scoreNode)
        
        self.addChild(pipesHolder)
        
        
        let destination = self.frame.width * 2;
        let move = SKAction.moveTo(x: -destination, duration: TimeInterval(10))//moving to the left side so we can see pipes coming to the screen
        let remove = SKAction.removeFromParent(); //take out of the scene 
        
        //
        pipesHolder.run(SKAction.sequence([move, remove]), withKey: "Move")
        
    }
    
    func spawnObstacles(){
        let spawn = SKAction.run({ () -> Void in
            self.createPipes();
        });
        
        let delay = SKAction.wait(forDuration: TimeInterval(2));//wait 2 seceonds to spawn obstacles
        let sequence = SKAction.sequence([spawn, delay]);//create a sequence , first call spawn then call delay then call spawn
        
        self.run(SKAction.repeatForever(sequence), withKey: "Spawn");//runAction forever
    }
    
    func createLabel(){
        scoreLabel.zPosition = 6;
        scoreLabel.position = CGPoint(x: 0, y: 450)
        scoreLabel.fontSize = 120;
        scoreLabel.text = "0"
        self.addChild(scoreLabel)
    
    }
    
    func incrementScore(){
        score += 1;
        scoreLabel.text = "\(score)"
    }
    
    func birdDied(){
        
        self.removeAction(forKey: "Spawn") //we want to stop spawning the pipes
        
        for child in children {
            if child.name == "Holder"{ //remove pipes in action statement in createpipes function
                child.removeAction(forKey: "Move")//stop any pipes currently moving to stop
            }
        }
        
        isAlive = false;
        
        bird.texture = bird.diedTexture; //change bird texture to diedTexture image we put in the birdclass
        
        let highscore = GameManager.instance.getHighscore();
        
        if highscore < score {
            //if the current score is greater than the saved highscore then we have a new highscore
            GameManager.instance.setHighscore(score);
        }
        
        let retry = SKSpriteNode(imageNamed: "Retry")
        let quit = SKSpriteNode(imageNamed: "Quit")
        
        retry.name = "Retry";
        retry.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        retry.position = CGPoint(x: -150, y: -150);
        retry.zPosition = 7;
        retry.setScale(0);
    
        quit.name = "Quit";
        quit.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quit.position = CGPoint(x: 150, y: -150);
        quit.zPosition = 7;
        quit.setScale(0);
        
        let scaleUp = SKAction.scale(to: 1, duration: TimeInterval(1)) //ever 1 sec our quit and retry button is going to go from scale 0 to 1 that is the view if i put 5 then the view of the button is going to be too big! this animation
        retry.run(scaleUp)
        quit.run(scaleUp)
        
        self.addChild(retry);
        self.addChild(quit);
    
    }
    
    
}
