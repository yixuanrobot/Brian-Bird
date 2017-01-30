//
//  GameplayScene.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/28/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {

    var bird = Bird();
    
    
    
    override func didMove(to view: SKView) {
        initialize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds();
    }
    
    func initialize(){
        createBird()
        createBackground();
        createGrounds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap();
    }
    
    func createBird() {
        bird = Bird(imageNamed: "Blue 1");//we can use imagedName since Bird inherientence from skspritenode\
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

}

