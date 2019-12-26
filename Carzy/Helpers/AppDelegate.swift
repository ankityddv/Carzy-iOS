//
//  AppDelegate.swift
//  Carzy
//
//  Created by ANKIT YADAV on 23/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        // Increase Launch Time
        Thread.sleep(forTimeInterval: 1.5)
        
        
        //check if already logged in
        
        if UserDefaults.standard.object(forKey: "KEY_UID") != nil {
            //logged in
            self.GoToMain()
        } else {
            //not logged in
            self.GoToStart()
        }
        return true
    }
    
    func GoToMain(){
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController

        self.window?.rootViewController = mainView
    }
    
    func GoToStart(){
        let regView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GetStartedViewController") as! GetStartedViewController
        
        self.window?.rootViewController = regView
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

