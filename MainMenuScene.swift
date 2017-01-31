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
                
            }
            
            if atPoint(location).name == "Bird"{
            
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
    
        self.addChild(birdBtn);
    }




}


























