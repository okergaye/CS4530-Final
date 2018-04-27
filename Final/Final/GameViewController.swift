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
    //define triangle geomotry memory
    
    
    let quad: [Float] = [
        -0.5,-0.5,
         0.5,-0.5,
        -0.5, 0.5,
         0.5, 0.5,
    ]

    
    let triangleDate: [Float] = [
        //add background sprite, top right half
        -1.0 , +1.0,
        +1.0 , +1.0,
        +1.0 , -1.0,
        //add background sprite, bottom left half
        -1.0 , +1.0,
        -1.0 , -1.0,
        +1.0 ,-1.0,
        
        //dpad
        +0.35 , -0.65,
        +1.0 , -0.65,
        +1.0  , -1.0,
        //bottm
        +0.35 , -0.65,
        +0.35 , -1.0,
        +1.0  , -1.0,

        //ship facing up, top right
        -0.5 , +0.125,
        -0.125 , +0.125,
        -0.125  , -0.125,
        //ship facing up, bottom left half
        -0.5 , +0.125,
        -0.5 , -0.125,
        -0.125 , -0.125,
        ]
    
    //textires are 0-1 referanced from the top left cornor
    let triangleTextureCoordinateData: [Float] = [
        //add background sprite, top right half
         0.0 , 0.0,
         1.0 , 0.0,
         //add background sprite, bottom left half
        // 0.0 , 0.0,
         0.0 , 1.0,
         1.0 , 1.0,

         1.0 , 1.0,
         
         //dpad top right half
        0.0 , 0.0,
        1.0 , 0.0,
        1.0 , 1.0,
        //  bottem left half
        0.0 , 0.0,
        0.0 , 1.0,
        1.0 , 1.0,
         
         //ship facing up, top right
         0.0 , 0.0,
         0.25 , 0.0,
         0.25 , 1.0,
        //ship facing up, bottom left half
         0.0 , 0.0,
         0.0 , 1.0,
         0.25 , 1.0,
        
        ]
    
 
    
    //define triangle color memory
    //    let triangleColorDate: [Float] = [
    //        1.0, 0.0, 0.0, 1.0,
    //        0.0, 1.0, 0.0, 1.0,
    //        0.0, 0.0, 1.0, 1.0,
    //        ]
    
    
    var jupTextureInfo: GLKTextureInfo =  GLKTextureInfo()
    var backgroundTextureInfo: GLKTextureInfo = GLKTextureInfo()
    var ship: GLKTextureInfo = GLKTextureInfo()
    var dpad: GLKTextureInfo = GLKTextureInfo()


    
    var animationX: Float = 0.0
    var animationY: Float = 0.0
    var animationX1: Float = 0.0
    var animationY1: Float = 0.0
    var program: GLuint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGL()
    }
    
    
    
    func setupGL(){
        //this sets up the context
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)! //this takes the api for its param
        EAGLContext.setCurrent(glkView.context)
        
        // define and compile a vertex shader
        let vertexShaderSource: NSString = """
            /*  attribute vec4 color; */
            /*  varying vec4 colorInterpolated; */

            attribute vec2 position;
            uniform vec2 translate;
            uniform vec2 scale;
            attribute vec2 textureCoordinate;
            varying vec2 textureCoordinateInterpolated;

            void main(){
          //gl_Position = vec4(position.x + translate.x , position.y + translate.y, 0.0, 1.0);
            gl_Position = vec4(position.x * scale.x + translate.x , position.y * scale.y + translate.y, 0.0, 1.0);
              /* colorInterpolated = color; */
                textureCoordinateInterpolated = textureCoordinate;

            }
        """
        var vertexShaderSourceMemory = vertexShaderSource.utf8String
        let vertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        glShaderSource(vertexShader, 1, &vertexShaderSourceMemory, nil)
        glCompileShader(vertexShader)
        var vertexShaderCompileSucceeded: GLint = 0
        glGetShaderiv(vertexShader, GLenum(GL_COMPILE_STATUS), &vertexShaderCompileSucceeded)
     // TODO define and compile a fragment shader
        let fragmentShaderSource: NSString = """
          /*   varying highp vec4 colorInterpolated; */
            varying highp vec2 textureCoordinateInterpolated;
            uniform sampler2D textureUnit;
            void main(){
              /* gl_FragColor = colorInterpolated; */
                gl_FragColor = texture2D(textureUnit , textureCoordinateInterpolated);
            }
        """
        var fragmentShaderSourceMemory = fragmentShaderSource.utf8String
        let fragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        glShaderSource(fragmentShader, 1, &fragmentShaderSourceMemory, nil)
        glCompileShader(fragmentShader)
        var fragmentShaderCompileSucceeded: GLint = 0
        glGetShaderiv(fragmentShader, GLenum(GL_COMPILE_STATUS), &fragmentShaderCompileSucceeded)
        //TODO Link the shaders into a program
        program = glCreateProgram()
        glAttachShader(program, vertexShader)
        glAttachShader(program, fragmentShader)
        //glBindAttribLocation(program, 0, "position")
        //the zero here is the same number as the first zero in the glvertexattribpointer(0..
        glBindAttribLocation(program, 0, "position")
        // glBindAttribLocation(program, 1, "color")
        glBindAttribLocation(program, 1, "textureCoordinate")
     //   glBindAttribLocation(program, 2, "scale")
        glLinkProgram(program)
        var linkSucceeded: GLint = 0
        glGetProgramiv(program, GLenum(GL_LINK_STATUS), &linkSucceeded)
        ////// use the program
        glUseProgram(program)
        //define triangle geometry memory
        //second param is number of verts r things to draw, could be more than 2, this func garentees that this is a const void*
        
//        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleDate)
//        glEnableVertexAttribArray(0)
        
                glEnableVertexAttribArray(0)
                glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, quad)
        
        //define triangle color memory
        //  glVertexAttribPointer(1, 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleColorDate)
        
        
        
        
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleTextureCoordinateData)
        glEnableVertexAttribArray(1)
        
//        glVertexAttribPointer(3, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, quad)
//        glEnableVertexAttribArray(3)
 
        
        
        
        
        
        ///if i want to swap textuers, i need this to be a member var, then call bindtexture in glkview
        jupTextureInfo =  try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "jup.png").cgImage!, options: [:])
        backgroundTextureInfo = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "splash.jpg").cgImage!, options: [:])
        ship = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "ship.png").cgImage!, options: [:])
        dpad = try! GLKTextureLoader.texture(with: #imageLiteral(resourceName: "dpad.png").cgImage!, options: [:])

   
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
       // #imageLiteral(resourceName: "dpad.png")
        glUniform1i(glGetUniformLocation(program, "textureUnit"), 0)
        //takes vals between 0-1, the last param is the alpha
        glClearColor(0.0, 0.0, 1.0, 1.0)
        

        
    }
    
    func update(){
        
        
        animationX += 0.0005
        animationY += 0.0005
        
        animationX1 -= 0.0001
        animationY1 += 0.0005
        
        
    }
    
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
     
        update()
        /// this is for the backrougn, dont need to modify beyeond this point
        //the string var here must match vetexShaderSource variable code translate
        //glUniform2f(glGetUniformLocation(program, "translate"), animationX, animationY)
        //draw a triangle
        //three params, fist is what primitave do you want to draw
        //ssecond one is asking for the indecies in an array that should be used to draw, called skip and take
        //third is the number of things you want to draw in number of vertices. so tri will have 3
        
        ////this is for all the non moving stuff.
//        glUniform2f(glGetUniformLocation(program, "scale"), 0, 0)
//        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)
        glUniform2f(glGetUniformLocation(program, "scale"), 1, 1)
        glUniform2f(glGetUniformLocation(program, "translate"), 0, 0)
        glBindTexture(GLenum(GL_TEXTURE_2D), backgroundTextureInfo.name)
//        glDrawArrays(GLenum(GL_TRIANGLES), 0, 6)//darw array of memory,  spesificly attirbue data
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)//darw array of memory,  spesificly attirbue data

//        glUniform2f(glGetUniformLocation(program, "translate"), 0, 0)
//        glBindTexture(GLenum(GL_TEXTURE_2D), dpad.name)
//        glDrawArrays(GLenum(GL_TRIANGLES), 6, 6)//darw array of memory,  spesificly attirbue data
//
//
//        glBindTexture(GLenum(GL_TEXTURE_2D), ship.name)
//        glUniform2f(glGetUniformLocation(program, "translate"), animationX, animationY)
//        glDrawArrays(GLenum(GL_TRIANGLES), 12, 6)//darw array of memory,  spesificly attirbue data


        
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
