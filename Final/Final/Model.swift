//
//  GameState.swift
//  Final
//
//  Created by Macintosh on 4/14/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation

//holder for consts and one static
struct M{
    static let A: Float =  (9.0 / 16.0)
    static let mu: Float = -0.01
    static var gameOverStatic: Bool = false
}

//model object
class Movable: Sprite{
    //var velocity: Float
    //or have a path
    var startTime: Double = 0.0
    var endTime: Double = 0.0
}

class Model: Codable{
    //GAMESTATE VARS
    public var showWelcome: Bool = false
    public var score: Int = 0
    public var inProgress: Bool = true
    public var level: Int = 1
    public var shipSpriteX: Float = 0
    public var shipSpriteY: Float = -0.8
    public var bulletSpriteY: Float = 1.1
    public var bulletSpriteX: Float = 1.1
    public var enemySpriteY: Float = 0
    public var enemySpriteX: Float = 0
    public var enemySpriteWidth: Float = 0
    public var enemySpriteHeight: Float = 0
    public var boomY: Float = 1.1
    public var boomX: Float = 1.1
    private var SVX: Float = 0
    private var SVY: Float = 0
    private var T: Float = Float()
    public var gameOverFlag: Bool = false
    public var gameWinFlag: Bool = false
    public var gameScoreOffsetX: Float = 0
    public var healthOffsetX: Float = 0
    public var animation: Float = 0
    
    //starting a new game
    public func NewGame(){
        showWelcome = false
        score = 0
        inProgress = true
        level = 1
        shipSpriteX  = 0
        shipSpriteY = -0.8
        bulletSpriteY = 1.1
        bulletSpriteX = 1.1
        enemySpriteY = 0
        enemySpriteX = 0
        enemySpriteWidth = 0
        enemySpriteHeight = 0
        boomY = 1.1
        boomX = 1.1
        SVX = 0
        SVY = 0
        T = Float()
        gameOverFlag = false
        gameWinFlag = false
        gameScoreOffsetX = 0
        healthOffsetX = 0
    }
    
    //gameLoop func
    func GameLoop(timePast: TimeInterval){
        T = Float(timePast)
        animation += Float(T) * 1.2
        shipSpriteX = shipSpriteX + ((SVX) * T)
        shipSpriteY = shipSpriteY + ((SVY) * T)
        bulletSpriteY = bulletSpriteY + (1.1 * T)
        
        let xDist = enemySpriteX - bulletSpriteX
        let yDist = enemySpriteY - bulletSpriteY
        let d: Float = sqrtf( (xDist * xDist ) + (yDist * yDist)  )
        
        //check bullet touches with enemy
        if(abs(d) <= (0.15) && level == 1){
            //goes off screen and an explosion goes in its place
            boomX = enemySpriteX
            boomY = enemySpriteY
            bulletSpriteY = 2.0
            enemySpriteX = 0.0
            enemySpriteY = -0.25
            shipSpriteY = 0.0
            shipSpriteX = 0.0
            //TODO maybe display next level banner, then go to next level
            gameScoreOffsetX = 0.1
            score = 1
            level = 2
        }else if(abs(d) <= 0.15 && level == 2){
            boomX = enemySpriteX
            boomY = enemySpriteY
            bulletSpriteY = 2.0
            enemySpriteX = 0.0
            enemySpriteY = 0.0
            gameScoreOffsetX = 0.2
            score = 2
            level = 3
        }else if(abs(d) <= 0.15 && level == 3){
            boomX = enemySpriteX
            boomY = enemySpriteY
            bulletSpriteY = 2.0
            enemySpriteX = 0.0
            enemySpriteY = 0.0
            gameScoreOffsetX = 0.3
            score = 3
            level = 4
        }
        
        //level spesfic stuff
        if(level == 2){
            enemySpriteX = enemySpriteX + (0 * T)
            enemySpriteY = enemySpriteY + (0 * T)
            enemySpriteWidth = 0.59
            enemySpriteHeight = 0.59
            boomX = 2.0
        }else if (level == 1){
            enemySpriteX = enemySpriteX + (0.006 * T)
            enemySpriteY = enemySpriteY + (-0.01 * T)
            enemySpriteWidth = 0.35
            enemySpriteHeight = 0.35
        }else if(level == 3){
            enemySpriteY = cos(animation) * 0.5
            enemySpriteWidth = 0.22
            enemySpriteHeight = 0.22
        }else if (level == 4){
            boomX = 2.0
            boomY = 2.0
            enemySpriteX = 2.0
            enemySpriteY = 2.0
            gameWinFlag = true
        }
        
        let xES = enemySpriteX - shipSpriteX
        let yES = enemySpriteY - shipSpriteY
        let dES: Float = sqrtf( (xES * xES ) + (yES * yES)  )
        //TODO check bullet touches with enemy
        if(abs(dES) < 0.1){
            gameOverFlag = true
            healthOffsetX = 0.0
            //goes off screen and an explosion goes in its place
            boomX = enemySpriteX
            boomY = enemySpriteY
            shipSpriteY = 2.0
            enemySpriteX = 2.0
            enemySpriteY = 2.0
        }
        
        if(upTapB){
            SVY += 0.01
        }
        if(downTapB){
            SVY -= 0.01
        }
        if(leftTapB){
            SVX -= 0.01
        }
        if(rightTapB){
            SVX += 0.01
            
        }
        
    }
    
    func fireTap(){
        bulletSpriteX = shipSpriteX
        bulletSpriteY = shipSpriteY + 0.1
    }
    
    //Handling button preses here
    var upTapB: Bool = false
    var downTapB: Bool = false
    var leftTapB: Bool = false
    var rightTapB: Bool = false
    
    func upTap(){
        upTapB = true
    }
    func downTap(){
        downTapB = true
    }
    func leftTap(){
        leftTapB = true
    }
    func rightTap(){
        rightTapB = true
    }
    func upRel(){
        upTapB = false
    }
    func downRel(){
        downTapB = false
    }
    func leftRel(){
        leftTapB = false
    }
    func rightRel(){
        rightTapB = false
    }
}
