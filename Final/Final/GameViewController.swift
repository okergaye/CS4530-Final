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
    private var dpadSprite = Sprite()
    private var shipSprite = Sprite()
    private var buttonSprite = Sprite()
    private var bulletSprite = Sprite()
    private var animation:Float = 0.0
    private var lastUpdate: Date = Date()
    
     public var jupTextureInfo: GLKTextureInfo =  GLKTextureInfo()
     public var backgroundTextureInfo: GLKTextureInfo = GLKTextureInfo()
     public var ship: GLKTextureInfo = GLKTextureInfo()
     public var dpad: GLKTextureInfo = GLKTextureInfo()
     public var buttonTex: GLKTextureInfo = GLKTextureInfo()
     public var bulletTex: GLKTextureInfo = GLKTextureInfo()


    

    override func viewDidLoad() {
        super.viewDidLoad()
        //this sets up the context
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)! //this takes the api for its param
        EAGLContext.setCurrent(glkView.context)

        setupGL()
    }
    
    func loadSpriteTextures(){
        jupTextureInfo =  try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "jup.png").cgImage!, options: [:])
        backgroundTextureInfo = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "splash.jpg").cgImage!, options: [:])
        ship = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "ship.png").cgImage!, options: [:])
        dpad = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "dpad.png").cgImage!, options: [:])
        buttonTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "button.png").cgImage!, options: [:])
        bulletTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "bulletSheet.png").cgImage!, options: [:])

    }
    
    func setupGL(){
        glClearColor(0.0, 0.0, 1.0, 1.0)
        
        loadSpriteTextures()
        
        sprite.texture = backgroundTextureInfo.name
        sprite.width = 2
        sprite.height = 2 * (16/9)

        
        dpadSprite.texture = dpad.name
        dpadSprite.width = 0.5
        dpadSprite.height = 0.5
        dpadSprite.x = 0.72
        dpadSprite.y = -0.85
        
        buttonSprite.texture = buttonTex.name
        buttonSprite.cutX = 0.1428
        buttonSprite.width = 0.5
        buttonSprite.height = 0.5
        buttonSprite.x = -0.72
        buttonSprite.y = -0.85
        
        shipSprite.texture = ship.name
        shipSprite.width = 0.25
        shipSprite.height = 0.25
        //1024 by 1024 are best for textures with frames. perfect squares for animat stiff
        shipSprite.cutX = 0.25
        
        bulletSprite.texture = bulletTex.name
        bulletSprite.width = 0.125
        bulletSprite.height = 0.125


        
        
        
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        update()
        //////////////start point for the new shit
        
        sprite.draw()
        dpadSprite.draw()
        buttonSprite.draw()
        shipSprite.draw()
        bulletSprite.draw()

        //this is in pixels, for teh vars
//        glViewport(0, 0, GLsizei(view.bounds.width * view.contentScaleFactor), GLsizei(view.bounds.height * view.contentScaleFactor))

        
    }
//    var jiggle: Float = 0.125

    func update(){
        let now = Date()
        let elapsed = now.timeIntervalSince(lastUpdate)
        lastUpdate = now
        animation += Float(elapsed) * 0.25
        //shipSprite.offsetY += animation
        
        let ani: Float = 0.125 * cos(animation) * 0.5
        bulletSprite.height = ani
        bulletSprite.width  = ani
//        if(jiggle >= 0.125){
//
//            bulletSprite.height += jiggle
//            bulletSprite.width += jiggle
//            jiggle += 0.005
//
//
//        }else if (jiggle <= 0.150){
//            bulletSprite.height += jiggle
//            bulletSprite.width += jiggle
//            jiggle += 0.005
//
//
//        }
        

        // shipSprite.x = Float(cos(animation)) * 0.9  //ithink this is the probl
        // shipSprite.y = Float(sin(animation)) * 0.9
        if(cos(animation) < 0.5){
            // shipSprite.offsetX = 0.25
        }
        else{
            //shipSprite.offsetX = 0
        }
        
        //TODO: call gameloop method in here GameModel.executeGameLoop(elapsed)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let location = touch.location(in: self.view)
        let berryBoundsX = view.center.x + (0.72 * view.bounds.width / 2)
        let berryBoundsY = view.center.y + (0.85 * view.bounds.height / 2 )
        let offsetX = view.center.x / 12
        let offsetY = view.center.y / 8
        
        let berryButX = view.center.x - (0.72 * view.bounds.width / 2)
        let berryButY = view.center.y + (0.85 * view.bounds.height / 2 )
        
        if(location.x > berryButX - offsetY && location.x < berryButX + offsetY && location.y > berryButY - offsetY && location.y < berryButY + offsetY){
            
        }
        
        
        ////DPAD STUFF
        //up clicked
        if(location.y < berryBoundsY && location.y > berryBoundsY - offsetY && location.x > berryBoundsX - offsetX && location.x < berryBoundsX + offsetX){
            shipSprite.y += 0.1 * M.A
            shipSprite.offsetX = 0.0
        }
        //down clicked
        else if(location.y < berryBoundsY + offsetY && location.y > berryBoundsY && location.x > berryBoundsX - offsetX && location.x < berryBoundsX + offsetX){
            shipSprite.y -= 0.1 * M.A
            shipSprite.offsetX = 0.50
        }
        //left click
        else if(location.y < berryBoundsY + offsetX && location.y > berryBoundsY - offsetX && location.x < berryBoundsX && location.x > berryBoundsX - offsetY){
            shipSprite.x -= 0.1
            shipSprite.offsetX = 0.25
        }
        //right clicked
        else if(location.y < berryBoundsY + offsetX && location.y > berryBoundsY - offsetX && location.x < berryBoundsX + offsetY && location.x > berryBoundsX){
            shipSprite.x += 0.1
            shipSprite.offsetX = 0.75
        }
        ////Dpad over!
        
    }
    
}
