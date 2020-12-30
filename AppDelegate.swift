//
//  AppDelegate.swift
//  hirotter
//
//  Created by 渡邉寛都 on 2020/03/09.
//  Copyright © 2020 WatanbeHiroto. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        NCMB.setApplicationKey("e971b28f66e0cca3fe25dee0da26e2a9668927e568687b315f62e25380d1d4d7", clientKey: "b44fba1e59c1e6619f066684bc637ab9e71129fd7f72fc36b8742a0637a8cea5")
        
        
        let ud = UserDefaults.standard
        let isLogin = ud.bool(forKey: "isLogin")
        
        if isLogin == true{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(identifier: "RootTabBarController")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()

        }else{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(identifier: "RootNavigationController")
            self.window?.rootViewController = rootViewController
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()

        }
        return true
        
        // Override point for customization after application launch.
        
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

