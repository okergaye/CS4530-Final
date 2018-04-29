//
//  Sprite.swift
//  Final
//
//  Created by Macintosh on 4/22/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import GLKit


//view objects (protrait)
// 9:16 retio needs to be appled to x and y to make actual squres
//x -> -1-1
// y goes from -1.777 - 1.777, both for elements on screen

class Sprite{
    
    var position: Vector = Vector()
    var posX: Float = 0.0
    var posY: Float = 0.0
    
    var x: Float = 0.0
    var y: Float = 0.0
    var width: Float = 1.0
    var height: Float = 1.0
    
    var offsetX: Float = 0.0
    var offsetY: Float = 0.0
    var texture: GLuint = 0
    var cutX: Float = 1.0
    var cutY: Float = 1.0
    
    // var rotation: Float = 0.0
    // var animation: something//array of tiles that are a set of locations in a file, with time attached to them, game updateloop will provide next tile
    
    
    func draw(){
        if(Sprite.program == 0){
            Sprite.setup()
        }
        glUniform2f(glGetUniformLocation(Sprite.program, "scale"), width, height)
        glUniform2f(glGetUniformLocation(Sprite.program, "translate"), x, y)
        glUniform2f(glGetUniformLocation(Sprite.program, "cut"), cutX, cutY)
        glUniform2f(glGetUniformLocation(Sprite.program, "offset"), offsetX, offsetY)
        glBindTexture(GLenum(GL_TEXTURE_2D), GLuint(texture) )
        glDrawArrays(GLenum(GL_TRIANGLE_STRIP), 0, 4)//darw array of memory,  spesificly attirbue data
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////STATIC BELOEW//////
    
    static private let quad: [Float] = [
        -0.5,-0.5,
        0.5,-0.5,
        -0.5, 0.5,
        0.5, 0.5,
        ]
    //textires are 0-1 referanced from the top left cornor
    static private let triangleTextureCoordinateData: [Float] = [
        0.0 , 1.0,
        1.0 , 1.0,
        0.0 , 0.0,
        1.0 , 0.0,
    ]
    static private var program: GLuint = 0
 
    
    private static func setup(){
        // define and compile a vertex shader
        let vertexShaderSource: NSString = """
            /*  attribute vec4 color; */
            /*  varying vec4 colorInterpolated; */

            attribute vec2 position;
            uniform vec2 translate;
            uniform vec2 scale;

            uniform vec2 offset;
            uniform vec2 cut;
            attribute vec2 textureCoordinate;
            varying vec2 textureCoordinateInterpolated;

            void main(){
            gl_Position = vec4(position.x * scale.x + translate.x , position.y * (9.0 / 16.0) * scale.y  + translate.y, 0.0, 1.0);

                textureCoordinateInterpolated = vec2(textureCoordinate.x * cut.x + offset.x, textureCoordinate.y * cut.y + offset.y);

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
        
        //REdefine openGL defaults
        //TODO what  changes will other opnegl Users in the program make?
        glEnableVertexAttribArray(0)
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, quad)
        
        
        glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleTextureCoordinateData)
        glEnableVertexAttribArray(1)
        
        glUniform1i(glGetUniformLocation(program, "textureUnit"), 0)
        
        ///if i want to swap textuers, i need this to be a member var, then call bindtexture in glkview
 
        glEnable(GLenum(GL_BLEND))
        glBlendFunc(GLenum(GL_SRC_ALPHA), GLenum(GL_ONE_MINUS_SRC_ALPHA))
        
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
