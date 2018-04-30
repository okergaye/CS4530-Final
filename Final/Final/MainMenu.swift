//
//  ViewController.swift
//  Final
//
//  Created by Macintosh on 4/9/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//

import UIKit

//delegate protocal for controler interactoin
protocol menuDelgate: class {
    
    func startGameView()
    func pushHighScoreView()
    func animateButton(sender: UIButton)
    func popHSView()
    
}

class MainMenu: UIViewController, menuDelgate {
    
    //vars
    var welcomeState: Bool!
    let menu: MainMenuView = MainMenuView()
    let highScoreView: HighScoreView = HighScoreView()
    let gameViewController: GameViewController = GameViewController()
    
    
    
    
    //main class fucntions
    override func viewDidLoad() {
        super.viewDidLoad()

        menu.Welcome.isHidden = welcomeState
        menu.menuDel = self
        highScoreView.menuDel = self
        
        //if its the first time opening, or returning after minimizing(nomater where they left at, return here)
       
         view = menu
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if(M.gameOverStatic){
            pushHighScoreView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        menu.Welcome.isHidden = welcomeState
        navigationController?.isNavigationBarHidden = true

        if menu.Welcome.isHidden == false {
          //  Timer.scheduledTimer(timeInterval: 2.0, target: menu, selector: #selector(menu.hideLabel), userInfo: nil, repeats: false)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0 , execute: {
                self.menu.hideLabel()
            })
        }
    }
    


    
    
    override func viewWillDisappear(_ animated: Bool) {
       // menu.Welcome.isHidden = false
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    //delegate fucntions
    
    func startGameView() {
        debugPrint("menuDel here")
        gameViewController.model.NewGame()
        
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func popHSView() {
        navigationController?.popViewController(animated: true)
    }
    
    func pushHighScoreView() {
        debugPrint("pushScoreView here")
        let T: UIViewController = UIViewController()
        T.view = highScoreView
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.pushViewController(T, animated: true)
        T.navigationController?.isNavigationBarHidden = true
        
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

