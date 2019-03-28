//
//  AppDelegate.swift
//  Twibos
//
//  Created by 彭韬 on 17/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        sleep(2)
        
        window = UIWindow()
        window?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window?.rootViewController = SNMainViewController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

}

