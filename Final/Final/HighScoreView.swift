//
//  MainMenuView.swift
//  Final
//
//  Created by Macintosh on 4/12/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation
import UIKit


class HighScoreView: UIView {
    
    var Title: UILabel!
    var Board: UIStackView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.contents = #imageLiteral(resourceName: "splash.jpg").cgImage

       // translatesAutoresizingMaskIntoConstraints = false
        
        Title = UILabel()
        Title.textAlignment = .center
        Title.baselineAdjustment = .alignCenters
        Title.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        Title.textColor = .white
        
        
        Board = UIStackView()
        Board.backgroundColor = UIColor.white
        Board.alignment = .center
        Board.axis = .vertical
        Board.distribution = .fill
        
       // Board.addArrangedSubview(Title)
       
        addSubview(Title)
        addSubview(Board)
    }
    
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let fontConst = UIFont.systemFont(ofSize: frame.width  * 0.09)

        Title.font = fontConst
        
        
        Title.text = "Top Players!"
       // Board.frame = frame
        Board.frame = CGRect(x: 0, y: 0 - (frame.height * 1/10), width: frame.width , height: frame.height - (frame.height * 1/10))
        Title.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height * 1/10)
    }
    
    
   
    
    
    
    // staticish stuff beloew this point.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("dumapple")
    }
    
    
    
    
    
    
    
    
    
    
}
