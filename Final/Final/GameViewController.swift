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
    
    private var level = Sprite()
    private var dpadSprite = Sprite()
    private var shipSprite = Sprite()
    private var buttonSprite = Sprite()
    private var bulletSprite = Sprite()
    private var enemySprite = Sprite()
    private var boomSprite = Sprite()

    
    private var animation:Float = 0.0
    private var lastUpdate: Date = Date()
    private var model: Model = Model()
    
    public var jupTextureInfo: GLKTextureInfo =  GLKTextureInfo()
    public var backgroundTextureInfo: GLKTextureInfo = GLKTextureInfo()
    public var shipSheetTex: GLKTextureInfo = GLKTextureInfo()
    public var dpad: GLKTextureInfo = GLKTextureInfo()
    public var buttonTex: GLKTextureInfo = GLKTextureInfo()
    public var bulletTex: GLKTextureInfo = GLKTextureInfo()
    public var boomTex: GLKTextureInfo = GLKTextureInfo()


    

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
     //   ship = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "ship.png").cgImage!, options: [:])
        shipSheetTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "shipTwo.png").cgImage!, options: [:])

        dpad = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "dpad.png").cgImage!, options: [:])
        buttonTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "button.png").cgImage!, options: [:])
        bulletTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "bulletSheet.png").cgImage!, options: [:])
        boomTex = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "boom.png").cgImage!, options: [:])


    }
    
    func setupGL(){
        glClearColor(0.0, 0.0, 1.0, 1.0)
        
        loadSpriteTextures()
        
        level.texture = backgroundTextureInfo.name
        level.width = 2
        level.height = 2 * (16/9)

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
        
        shipSprite.texture = shipSheetTex.name
        shipSprite.width = 0.25
        shipSprite.height = 0.25
        //1024 by 1024 are best for textures with frames. perfect squares for animat stiff
        shipSprite.cutX = 0.333
        shipSprite.cutY = 0.12
        shipSprite.offsetX = 0.33
        shipSprite.offsetY = 0.0
   

        bulletSprite.texture = bulletTex.name
        bulletSprite.width = 0.15
        bulletSprite.height = 0.15
    
        
        enemySprite.texture = shipSheetTex.name
        enemySprite.cutY = 0.1739
        enemySprite.cutX = 0.5
        enemySprite.width = 0.4
        enemySprite.height = 0.4
        enemySprite.offsetX = 0.0
        enemySprite.offsetY = 0.69
        
        boomSprite.texture = boomTex.name
        boomSprite.cutY = 0.25
        boomSprite.cutX = 0.25
        boomSprite.width = 0.35
        boomSprite.height = 0.35
        boomSprite.offsetX = 0.0
        boomSprite.offsetY = 0.0
  
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        update()
        
        //////////////start point for the new shit
        level.draw()
        dpadSprite.draw()
        buttonSprite.draw()
        shipSprite.draw()
        bulletSprite.draw()
        enemySprite.draw()
        boomSprite.draw()
        
        

        //this is in pixels, for teh vars
//        glViewport(0, 0, GLsizei(view.bounds.width * view.contentScaleFactor), GLsizei(view.bounds.height *          view.contentScaleFactor))

        
    }

    fileprivate func bulletAnimation() {
        //shipSprite.offsetY += animation
        var ani: Float = 0
        if(cos(animation) > 0){
            //idk how these numbers affect the animation, but its working..
            ani = 0.15 * (cos(animation) * 0.5 + 0.5)
            
        }else{
            ani = 0.15 * (-cos(animation) * 0.5 + 0.5)
            
        }
        bulletSprite.height = ani
        bulletSprite.width  = ani
        
        enemySprite.height = ani + 0.4
        enemySprite.width  = ani + 0.4
        
        var frame = Int(animation) % 4
        switch frame {
        case 0:
            boomSprite.offsetX = 0.0
        case 1:
            boomSprite.offsetX = 0.25
        case 2:
            boomSprite.offsetX = 0.5
        case 3:
            boomSprite.offsetX = 0.75
        default:
            debugPrint("you should never see this, apple wanted it")
        }
    }
    


    func update(){
        //setup
        let now = Date()
        let elapsed = now.timeIntervalSince(lastUpdate)
        lastUpdate = now
        animation += Float(elapsed) * 3.5
        
        //bullet speed
        bulletAnimation()
        
        shipSprite.x = model.shipSpriteX
        shipSprite.y = model.shipSpriteY
        
        bulletSprite.y = model.bulletSpriteY
        bulletSprite.x = model.bulletSpriteX
        
        enemySprite.x = model.enemySpriteX
        enemySprite.y = model.enemySpriteY
        
        boomSprite.x = model.boomX
        boomSprite.y = model.boomY

        
        
        

        //TODO: call gameloop method in here GameModel.executeGameLoop(elapsed)
       // Model.GameLoop(elapsed)
        model.GameLoop(timePast: elapsed)
    }

    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        buttonSprite.offsetX = 0

    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {return}
//        let location = touch.location(in: self.view)
//        let berryBoundsX = view.center.x + (0.72 * view.bounds.width / 2)
//        let berryBoundsY = view.center.y + (0.85 * view.bounds.height / 2 )
//        let offsetX = view.center.x / 12
//        let offsetY = view.center.y / 8
//        if(location.y < berryBoundsY && location.y > berryBoundsY - offsetY && location.x > berryBoundsX - offsetX && location.x < berryBoundsX + offsetX){
//            model.upTap()
//
//            shipSprite.offsetX = 0.33
//            shipSprite.offsetY = 0.12
//
//        }
        
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
            model.fireTap()
            
            
            buttonSprite.offsetX = 0.1428
            
        }
        
        
        ////DPAD STUFF
        //up clicked
        if(location.y < berryBoundsY && location.y > berryBoundsY - offsetY && location.x > berryBoundsX - offsetX && location.x < berryBoundsX + offsetX){
            model.upTap()
            
            shipSprite.offsetX = 0.33
            shipSprite.offsetY = 0.12

        }
        //down clicked
        else if(location.y < berryBoundsY + offsetY && location.y > berryBoundsY && location.x > berryBoundsX - offsetX && location.x < berryBoundsX + offsetX){
            model.downTap()
            shipSprite.offsetX = 0.33
            shipSprite.offsetY = 0.0

        }
        //left click
        else if(location.y < berryBoundsY + offsetX && location.y > berryBoundsY - offsetX && location.x < berryBoundsX && location.x > berryBoundsX - offsetY){
            model.leftTap()
            shipSprite.offsetY = 0.12

            shipSprite.offsetX = 0
        }
        //right clicked
        else if(location.y < berryBoundsY + offsetX && location.y > berryBoundsY - offsetX && location.x < berryBoundsX + offsetY && location.x > berryBoundsX){
            model.rightTap()
            
            shipSprite.offsetY = 0.12
            shipSprite.offsetX = 0.66
        }
        ////Dpad over!
        
    }
    
}
