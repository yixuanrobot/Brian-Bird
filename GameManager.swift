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

    func getBird() -> String {
        return birds[birdIndex];
    }




}
