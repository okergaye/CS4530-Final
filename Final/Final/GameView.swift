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

class GameView: GLKViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sets up the context
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)! //this takes the api for its param
        EAGLContext.setCurrent(glkView.context)
        
        //takes vals between 0-1, the last param is the alpha
        glClearColor(1.0, 0.0, 0.0, 1.0)
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
