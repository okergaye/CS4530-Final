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


//the orgin is always the cencter of the drawable area
class GameViewController: GLKViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //this sets up the context
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)! //this takes the api for its param
        EAGLContext.setCurrent(glkView.context)
        
        // define and compile a vertex shader
        
        // define and compile a fragment shader
        
        // Link the shaders into a program
        
        // use the program
        
        
        
        
        //takes vals between 0-1, the last param is the alpha
        glClearColor(1.0, 0.0, 0.0, 1.0)
        
        
        
        
    }
    
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
        
        //define triangle memory
        let triangleDate: [Float] = [
            +0.80, -0.30,
            -0.30, +0.70,
            -0.65, -0.65,
            
        ]
        
        //second param is number of verts r things to draw, could be more than 2, this func garentees that this is a const void*
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleDate)
        //GLboolean(GL_FALSE)
        
        //draw a triangle
        //three params, fist is what primitave do you want to draw
        //ssecond one is asking for the indecies in an array that should be used to draw, called skip and take
        //third is the number of things you want to draw in number of vertices. so tri will have 3
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)//darw array of memory,  spesificly attirbue data
        //
    }
    
    
    
    
    
}
