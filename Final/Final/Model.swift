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
    static let mu: Float = -0.01
    
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

//model object
class Movable: Sprite{
    //var velocity: Float
    //or have a path
    var startTime: Double = 0.0
    var endTime: Double = 0.0
    var path: [Vector] = []
    
    
}

class Model {
    
    
    public var shipSpriteX: Float = 0
    public var shipSpriteY: Float = -0.8
    public var bulletSpriteY: Float = 1.1
    public var bulletSpriteX: Float = 1.1
    public var enemySpriteY: Float = 0
    public var enemySpriteX: Float = 0
    public var boomY: Float = 1.1
    public var boomX: Float = 1.1
    private var SVX: Float = 0
    private var SVY: Float = 0
    private var T: Float = Float()
    
    public var boomFlag: Bool = false

    //Circle collision: object1 collides with object2 if the distance between them is less than the sum of their radii. Be sure to account for punch through!
    func GameLoop(timePast: TimeInterval){
        T = Float(timePast)
        
        shipSpriteX = shipSpriteX + (SVX * T)
        shipSpriteY = shipSpriteY + (SVY * T)
        bulletSpriteY = bulletSpriteY + (1.1 * T)
     
        enemySpriteX = enemySpriteX + (0.006 * T)
        enemySpriteY = enemySpriteY + (-0.01 * T)
        
        let xDist = enemySpriteX - bulletSpriteX
        let yDist = enemySpriteY - bulletSpriteY
        
        let d: Float = sqrtf( (xDist * xDist ) + (yDist * yDist)  )
        //TODO check bullet touches with enemy
        if(abs(d) < 0.1){
            
            boomFlag = true
       
            //goes off screen and an explosion goes in its place
            boomX = enemySpriteX
            boomY = enemySpriteY
            
            bulletSpriteY = 1.1
            enemySpriteX = 1.1
            enemySpriteY = 1.1

        }
        
        
        
        
        //TODO check enemey touches player craft
        let xES = enemySpriteX - shipSpriteX
        let yES = enemySpriteY - shipSpriteY
        
        let dES: Float = sqrtf( (xES * xES ) + (yES * yES)  )
        //TODO check bullet touches with enemy
        if(abs(dES) < 0.1){
            
            boomFlag = true
            
            //goes off screen and an explosion goes in its place
            boomX = enemySpriteX
            boomY = enemySpriteY
            
            shipSpriteY = 1.1
            enemySpriteX = 1.1
            enemySpriteY = 1.1
            
        }
        
        
    }
    
    func fireTap(){
        bulletSpriteX = shipSpriteX
        bulletSpriteY = shipSpriteY + 0.1
        
        
    }
    func fireHold(){
        
        
    }
    
    
    func upTap(){
        
        SVY += 0.01
        
        
    }
    
    func downTap(){
        SVY -= 0.01

        
    }
    func leftTap(){
        SVX -= 0.01

    }
    func rightTap(){
        SVX += 0.01

    }
    func upHold(){}
    func downHold(){}
    func leftHold(){}
    func rightHold(){}

    

    
    
}
