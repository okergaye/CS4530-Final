//
//  GameView.swift
//  Final
//
//  Created by Macintosh on 4/15/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation
import GLKit
//import OpenGLES

//this now becomes the game engine
//the orgin is always the cencter of the drawable area
class GameViewController: GLKViewController {
    //define triangle geomotry memory
    private var sprite = Sprite()
    private var sprite2 = Sprite()
    private var shipSprite = Sprite()
    private var animation:Float = 0.0
    private var lastUpdate: Date = Date()
    
     public var jupTextureInfo: GLKTextureInfo =  GLKTextureInfo()
     public var backgroundTextureInfo: GLKTextureInfo = GLKTextureInfo()
     public var ship: GLKTextureInfo = GLKTextureInfo()
     public var dpad: GLKTextureInfo = GLKTextureInfo()
    
    let triangleDate: [Float] = [
       

        //ship facing up, top right
        -0.5 , +0.125,
        -0.125 , +0.125,
        -0.125  , -0.125,
        //ship facing up, bottom left half
        -0.5 , +0.125,
        -0.5 , -0.125,
        -0.125 , -0.125,
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        //this sets up the context
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)! //this takes the api for its param
        EAGLContext.setCurrent(glkView.context)
        
        
        setupGL()
    }
    
    func setupGL(){
        glClearColor(0.0, 0.0, 1.0, 1.0)
        jupTextureInfo =  try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "jup.png").cgImage!, options: [:])
        backgroundTextureInfo = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "splash.jpg").cgImage!, options: [:])
        ship = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "ship.png").cgImage!, options: [:])
        dpad = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "dpad.png").cgImage!, options: [:])
        
        sprite.texture = backgroundTextureInfo.name
        sprite.width = 2
        sprite.height = 2

        
        sprite2.texture = dpad.name
        sprite2.width = 0.5
        sprite2.height = 0.25
        sprite2.x = 0.72
        sprite2.y = -0.85
        
        shipSprite.texture = ship.name
        shipSprite.width = 0.25
        shipSprite.height = 0.25
        
        
    }
    
    func update(){
        let now = Date()
        let elapsed = now.timeIntervalSince(lastUpdate)
        lastUpdate = now
        animation += Float(elapsed) * 0.25
        
        shipSprite.offsetX = 0.5
        //shipSprite.offsetY += animation

        shipSprite.x = Float(cos(animation)) * 0.9  //ithink this is the probl
        shipSprite.y = Float(sin(animation)) * 0.9
        //TODO: call gameloop method in here GameModel.executeGameLoop(elapsed)
    }
    
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        update()
        //////////////start point for the new shit
        
        sprite.draw()
        sprite2.draw()
        
        shipSprite.draw()


        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self.view)
        
//        location.
//        if(location.x > self.view.bounds.width / 8){
//
//
//        }else if (){
//
//        }else if(){
//
//        }else{
//
//        }
        
        
        
    }
    
}
