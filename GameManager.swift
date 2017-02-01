//
//  GameManager.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/30/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import Foundation

class GameManager {

    static let instance = GameManager();
    
    private init(){}
    
    var birdIndex = Int(0);
    
    var birds = ["Blue", "Green", "Red"];
    
    func incrementIndex(){
        birdIndex += 1;
        if birdIndex == birds.count {
            birdIndex = 0;
        }
        
    }

    func getBird() -> String {
        return birds[birdIndex];
    }

    func setHighscore(_ highscore: Int) { //because we are saving only one item we don't need all that nsdefaults archiever
        UserDefaults.standard.set(highscore, forKey: "Highscore");
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "Highscore"); //retun value highscore
    }

}
