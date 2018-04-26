//
//  Sprite.swift
//  Final
//
//  Created by Macintosh on 4/22/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation


//view objects (protrait)
// 9:16 retio needs to be appled to x and y to make actual squres
//x -> -1-1
// y goes from -1.777 - 1.777, both for elements on screen
class Sprite{
    var position: Vector = Vector()
    var x: Float = 0
    var y: Float = 0
    //var image: UI
    var width: Float = 0.0
    var height: Float = 0.0
   // var rotation: Float = 0.0
   // var animation: something//array of tiles that are a set of locations in a file, with time attached to them, game updateloop will provide next tile
    func draw(){
        //TODO how to perfomailty draw 400 things
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
