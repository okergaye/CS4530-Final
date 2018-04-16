//
//  ViewController.swift
//  Final
//
//  Created by Macintosh on 4/9/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import UIKit



class MainMenu: UIViewController, menuDelgate {
    
    //vars
    var welcomeState: Bool!
    let menu: MainMenuView = MainMenuView()
    let highScoreView: HighScoreView = HighScoreView()
    let gameViewController: GameViewController = GameViewController()
    
    //delegate fucntions
    func startGameView() {
        //this is being called twice, why?
        debugPrint("menuDel here")
        view = gameViewController.view
    }
    
    func pushHighScoreView() {
        debugPrint("pushScoreView here")
        let T: UIViewController = UIViewController()
        T.view = HighScoreView()
        var stockerplzWhyNoPush = 0
        navigationController?.pushViewController(T, animated: true)
        
        //view = HighScoreView()
    }
    
    
    //main class fucntions
    override func viewDidLoad() {
        super.viewDidLoad()

        menu.Welcome.isHidden = welcomeState
        menu.menuDel = self

        //display welcome thing
        //if it is false. make it not, then time display
        
        //if its the first time opening, or returning after minimizing(nomater where they left at, return here)
       
        let thisisnotmenuanymore = 0
        // view = menu
        view = highScoreView
        // view = gameViewController.view
        
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

