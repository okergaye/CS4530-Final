//
//
//  AppDelegate.swift
//  Final
//
//  Created by Macintosh on 4/9/18.
//  Copyright © 2018 Osama Kergaye. All rights reserved.
//
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainMenu: MainMenu!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
       // UIButton.appearance().tintColor = .white

        
        mainMenu = MainMenu()
        mainMenu.welcomeState = false
        window?.rootViewController = UINavigationController(rootViewController: mainMenu)

        mainMenu.navigationController?.isNavigationBarHidden = true
        window?.makeKeyAndVisible()
        restoreAlarmData()

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        //save start
//        let json = M.saveToJson()
//        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let filePath = directoryPath + "thissucksbutIAMLEARNING.txt"
//        let myFilePath: URL = URL(fileURLWithPath: filePath)
//        do{
//            try json.write(to: myFilePath)
//        }
//        catch {
//            //meh
//        }
    }

    
    func applicationWillEnterForeground(_ application: UIApplication) {
        mainMenu.welcomeState = false
        mainMenu.viewDidAppear(false)
        restoreAlarmData()

        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //load func for restoring alarm data
    func restoreAlarmData(){
        
        //do file pathing stuff
        let filePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path: String = filePath + "thissucksbutIAMLEARNING.txt"
        let url: URL = URL(fileURLWithPath: path)
        
        //now try and restore
        var data: Data
        do{
            data = try Data(contentsOf: url)
        }catch{
            data = Data()
        }
        
        //turn it back into my struct file, get it out of the stored json
//        M.loadJson(from: data)
        
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Final")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

