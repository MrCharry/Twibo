//
//  SNNavigationController.swift
//  Twibos
//
//  Created by 彭韬 on 17/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit


class SNNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
        
    }
    @objc fileprivate func popParent() {
        
        popViewController(animated: true)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let count = childViewControllers.count
        
        if count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            var title = "Back"
            
            if let vc = viewController as? SNBaseController {
                
                if count == 1 {
                    
                    title = childViewControllers.first?.title ?? "Back"
                    vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popParent), isBack: true)
                }
                
                vc.navItem.title = "Page \(count)"
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popParent), isBack: true)
                
                
            }
            
        }

        super.pushViewController(viewController, animated: true)
    }

}
