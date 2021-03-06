//
//  Bird.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/29/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Bird: UInt32 = 1;
    static let Ground: UInt32 = 2;
    static let Pipes: UInt32 = 3;
    static let Score: UInt32 = 4;
    
    
}

class Bird: SKSpriteNode {
    
    var birdAnimation = [SKTexture]();
    var birdAnimationAction = SKAction();
    
    var diedTexture = SKTexture();

    func initalize() {
        
        for i in 2..<4{
            let name = "\(GameManager.instance.getBird()) \(i)"
            birdAnimation.append(SKTexture(imageNamed: name));
        }
        
        birdAnimationAction = SKAction.animate(with: birdAnimation, timePerFrame: 0.08, resize: true, restore: true)
        
        diedTexture = SKTexture(imageNamed: "\(GameManager.instance.getBird()) 4")
        
        self.name = "Bird"
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2);
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.allowsRotation = false; //for the bird does not rotate
        self.physicsBody?.categoryBitMask = ColliderType.Bird;
        self.physicsBody?.collisionBitMask = ColliderType.Ground | ColliderType.Pipes; //because birds want to collide these items
        self.physicsBody?.contactTestBitMask = ColliderType.Ground | ColliderType.Pipes | ColliderType.Score // becasue we want to be notify when the bird collides with these items
        
    }
    
    func flap(){
    self.physicsBody?.velocity = CGVector(dx: 0, dy: 0);//making bird normalized meaning the body is not moving so making body stop before apply impulse
    self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 120)) //when touches screen bird move up with momentum in the touchesbegan function from gameplayscene.
    self.run(birdAnimationAction)
        
    }



}
