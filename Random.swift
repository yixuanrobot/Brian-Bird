//
//  Random.swift
//  Brian Bird
//
//  Created by Brian Canela on 1/30/17.
//  Copyright © 2017 CanelaApps. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{

    //NYTHING WE TYPE HERE WILL BE CGFLOAT
    public static func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
       
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + firstNum;
    }
    
}
