//
//  MainMenuScene.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/30/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene{

    var birdBtn = SKSpriteNode();
    
    var scoreLabel = SKLabelNode();
    
    override func didMove(to view: SKView) { //first function when we view our scene
        initialize();
    }
    
    func initialize(){
        createBG();
        createButtons();
        createBirdButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)//get location from mainmenuscene
            
            if atPoint(location).name == "Play" {
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay!.scaleMode = .aspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.doorway(withDuration: TimeInterval(1)));
            }
            
            if atPoint(location).name == "Highscore" {
                scoreLabel.removeFromParent()
                createLabel();
            }
            
            if atPoint(location).name == "Bird"{
                //when we touch our bird btn in the mainmenu we will increment index
                GameManager.instance.incrementIndex()
                birdBtn.removeFromParent();////remove current birdbtn
                createBirdButton();
                
            }
        }
    }
    
    func createBG(){
        let bg = SKSpriteNode(imageNamed: "BG Day");
        bg.anchorPoint = CGPoint(x:0.5, y:0.5)
        bg.position = CGPoint(x: 0, y: 0)
        bg.zPosition = 0;
        self.addChild(bg)
    
    }

    func createButtons(){
        let play = SKSpriteNode(imageNamed: "Play")
        let highscore = SKSpriteNode(imageNamed: "Highscore")
        
        play.name = "Play"
        play.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        play.position = CGPoint(x: -180, y: -50)
        play.zPosition = 1;
        play.setScale(0.7)
        
        highscore.name = "Highscore"
        highscore.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        highscore.position = CGPoint(x: 180, y: -50)
        highscore.zPosition = 1;
        highscore.setScale(0.7)
        
        self.addChild(play)
        self.addChild(highscore);
        
    }
    
    func createBirdButton() {
        birdBtn = SKSpriteNode(imageNamed: "Blue 1")
        birdBtn.name = "Bird"
        birdBtn.anchorPoint = CGPoint(x:0.5, y: 0.5)
        birdBtn.position = CGPoint(x: 0, y: 200)
        birdBtn.setScale(1.3)
        birdBtn.zPosition = 3;
    
        var birdAnim = [SKTexture](); //store all of animation
        
        for i in 1..<4 {
            //in gamemanager we put birds[birdsIndex] to get Blue,Red, or Green then so  i is set to 1-3
                let name = "\(GameManager.instance.getBird()) \(i)";
            birdAnim.append(SKTexture(imageNamed: name));
        }
        
        let animateBird = SKAction.animate(with: birdAnim, timePerFrame: 0.1, resize: true, restore: true)
        birdBtn.run(SKAction.repeatForever(animateBird))
        
        
        self.addChild(birdBtn);
    }

    func createLabel() {
        scoreLabel = SKLabelNode(fontNamed: "04b_19");
        scoreLabel.fontSize = 120;
        scoreLabel.position = CGPoint(x: 0, y: -400);
        scoreLabel.text = "\(GameManager.instance.getHighscore())";
        self.addChild(scoreLabel);
    }


}


























