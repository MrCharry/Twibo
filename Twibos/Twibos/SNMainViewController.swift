//
//  SNMainViewController.swift
//  Twibos
//
//  Created by 彭韬 on 17/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit

class SNMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        
    }


}

// Similar with Classification in OC, used to slice code block in Swift as well
// Convenient to code maintenance
// Warnning: The same with Classification in OC, it can't define property in extension
extension SNMainViewController {
    
    // Set all sub Controller
    func setupChildControllers() {
        
        let array = [
            ["clsName": "SNHomeController", "title": "Home", "imageName": ""]
        ]
        var arrayM = [UIViewController]()
        
        for dict in array {
            arrayM.append( controller(dict: dict) )
        }
        viewControllers = arrayM
    }
    
    // Use dictionary to create a sub controller
    private func controller( dict: [String: String] ) -> UIViewController {
        
        // 1. Get contents of dictionary
        guard let clsName = dict["clsName"],
        let  title = dict["title"],
        let imageName = dict["imageName"],
        let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
            else {
            
            return UIViewController()
            
        }
        
        // 2. Create View Controller
        // 1> Transfer clsName to cls
        let vc = cls.init()
        vc.title = title
        let nav = SNNavigationController(rootViewController: vc)
        
        return nav                
        
        
    }
}
