//
//  ViewController.swift
//  Final
//
//  Created by Macintosh on 4/9/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, MainMenuViewDelegate {
    
    
    
    //vars
    var welcomeState: Bool!
    let menu: MainMenuView = MainMenuView()

    
    //delegate fucntions
    func startGameView() {
        debugPrint("menuDel here")
        view = GameView().view
    }
    
    
    //main class fucntions
    override func viewDidLoad() {
        super.viewDidLoad()

        menu.Welcome.isHidden = welcomeState
        
        //display welcome thing
        //if it is false. make it not, then time display
        
        //if its the first time opening, or returning after minimizing(nomater where they left at, return here)
       
        view = menu

        
        //view.backgroundColor = .green
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        menu.Welcome.isHidden = welcomeState

        if menu.Welcome.isHidden == false {
            // menu.Welcome.isHidden = true
            Timer.scheduledTimer(timeInterval: 2.0, target: menu, selector: #selector(menu.hideLabel), userInfo: nil, repeats: false)
        }
    }
    


    
    
    override func viewWillDisappear(_ animated: Bool) {
       // menu.Welcome.isHidden = false
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

