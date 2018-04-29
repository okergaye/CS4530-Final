//
//  GameState.swift
//  Final
//
//  Created by Macintosh on 4/14/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation

struct M{
    static let A: Float =  (9.0 / 16.0)
    
}
class GAMESTATE: Codable{
    
    //vars
    var showWelcome: Bool = false
    var score: Int
    var inProgress: Bool
    var level: Int
    
    init() {
        score = 0
        inProgress = false
        showWelcome = false
        level = 0
    }
    

    
}


class Model {
    
    func GameLoop(){
        
        
    }
    
    

    
}
