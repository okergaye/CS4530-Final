//
//  MainMenuView.swift
//  Final
//
//  Created by Macintosh on 4/12/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import Foundation
import UIKit

//delegate protocal for controler interactoin
protocol menuDelgate: class {
    
    func startGameView()
    func pushHighScoreView()
   
}


class MainMenuView: UIView {
    
    weak var menuDel: menuDelgate?

    var StartGameButton: UIButton!
    var Title: UILabel!
    var HighScoreButton: UIButton!
    var Welcome: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //this one zooms in
        //backgroundColor = UIColor(patternImage: UIImage(named: "splash.jpg")!)
        
        //this one looks better but has to be wirtin in a comment first
        layer.contents = #imageLiteral(resourceName: "splash.jpg").cgImage
    
        let buttonColor = UIColor.black.withAlphaComponent(0.4)
        
        StartGameButton = UIButton()
        Title = UILabel()
        HighScoreButton = UIButton()
        Welcome = UILabel()
        
        Title.textAlignment = .center
        Title.baselineAdjustment = .alignCenters
        Title.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        Title.textColor = .white
        
        Welcome.textAlignment = .center
        Welcome.baselineAdjustment = .alignCenters
        Welcome.backgroundColor = buttonColor
        Welcome.isHidden = false
        Welcome.textColor = .white
        
        StartGameButton.backgroundColor = buttonColor
        HighScoreButton.backgroundColor = buttonColor
        
        StartGameButton.addTarget(self, action: #selector(startGameFunc) , for: .touchDown)
        HighScoreButton.addTarget(self, action: #selector(highScoreButtonPress), for: UIControlEvents.touchDown)
        
        addSubview(HighScoreButton)
        addSubview(Title)
        addSubview(StartGameButton)
        addSubview(Welcome)

        
    }
    
    @objc func startGameFunc(sender: UIButton){
       animateButton(sender: sender)
        debugPrint("starGameFunc in MainMenuView")
      // menuDel?.startGameView()

    }
    
    
    @objc func highScoreButtonPress(sender: UIButton){
        animateButton(sender: sender)
        debugPrint("highscorebuttonpreessss in MainMenuView")
        
        menuDel?.pushHighScoreView()

    }

    
    
   
    @objc func hideLabel() {
        Welcome.isHidden = true
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        let fontConst = UIFont.systemFont(ofSize: frame.width  * 0.09)

        StartGameButton.titleLabel?.font = fontConst
        Title.font = fontConst
        Welcome.font = fontConst
        HighScoreButton.titleLabel?.font = fontConst

        StartGameButton.setTitle("Start Game", for: .normal)
        Welcome.text = "WELCOME!!"
        Title.text = "Flay-O-Final"
        HighScoreButton.setTitle("High Scores", for: .normal)
        
        Title.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height * 1/10)
        StartGameButton.frame = CGRect(x: 0, y: frame.height * 5/8 , width: frame.width, height: frame.height * 1 / 8)
        HighScoreButton.frame = CGRect(x: 0, y: frame.height * 0.775 , width: frame.width, height: frame.height * 1 / 8)
        Welcome.frame = CGRect(x: 0, y: frame.height * 2/10, width: frame.width , height: frame.height * (1/8))
    }
    
    
    
    
    
    
    // staticish stuff beloew this point.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("dumapple")
    }
    
    //animates button press
    func animateButton(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(1.90),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {sender.transform = CGAffineTransform.identity},
                       completion: {Void in()} )
    }
    
    
}

