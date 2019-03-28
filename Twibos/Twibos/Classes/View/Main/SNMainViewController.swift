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
        setupComposeButton()
        composeAction()
        
    }
    
    /*
      If this method is implemented by a viewController, then all children of this controller will inherit the orientations.
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Setup Listening Method
    // Ensure that the function can only be called in current file
    // @objc: Allow the function to be called with OC mechanism when running
    @objc fileprivate func composeAction() {
        print("Compose Somethings!")
        
        // Test device orientations
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.cz_random()
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
        
    
    }
    
    // MARK: - A composeButton
    fileprivate lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
}

// Similar with Classification in OC, used to slice code block in Swift as well
// Convenient to code maintenance
// Warnning: The same as Classification in OC, it can't define property in extension
extension SNMainViewController {
    
    // Setup composeButton
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // Calculate the width of composeButton
        let count = CGFloat(childViewControllers.count)
        let width = tabBar.bounds.width / count - 1
        
        // Set the coordinate that composeButton inserts
        // Positive number: shrink; Negative: expend
        composeButton.frame = tabBar.bounds.insetBy(dx: width*2, dy: 0)
        
        // Add Target
        composeButton.addTarget(self, action: #selector(composeAction), for: .touchUpInside)
        
    }
    
    
    // Set all sub Controller
    fileprivate func setupChildControllers() {
        
        // Get data from JSON
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
            let data = NSData.init(contentsOfFile: path),
            let array = try? JSONSerialization.jsonObject( with: data as Data, options: [] ) as? [ [String: Any] ]
            else {
                return
        }
        
//        let array: [ [String: Any] ] = [
//            ["clsName": "SNHomeController", "title": "Home", "imageName": "home",
//             "visitorInfo": ["imgName": "", "content": "Nothings"]
//            ],
//            ["clsName": "SNMessageController", "title": "Message", "imageName": "message_center",
//             "visitorInfo": ["imgName": "visitordiscover_image_message", "content": "Message Page"]
//             ],
//            ["clsName": "UIViewController"],
//            
//            ["clsName": "SNDiscoverController", "title": "Discover", "imageName": "discover",
//             "visitorInfo": ["imgName": "visitordiscover_image_message", "content": "Discover Page"]
//             ],
//            ["clsName": "SNProfileController", "title": "Me", "imageName": "profile",
//             "visitorInfo": ["imgName": "visitordiscover_image_profile", "content": "Profile Page"]
//             ]
//        ]
        
        var arrayM = [UIViewController]()
        
        for dict in array! {
            arrayM.append( controller(dict: dict) )
        }
        viewControllers = arrayM
        
        // testify the data format of array(json)
//        (array as NSArray).write(toFile: "/Users/Charry/Desktop/demo.plist", atomically: true)
//        (array as NSArray).write(toFile: "/Users/Charry/Desktop/demo.json", atomically: true)
        // export array as a json
//        let jsonData = try! JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
//        
//        (jsonData as NSData).write(toFile: "/Users/Charry/Desktop/Main.json", atomically: true)
        
    }

    
    
    // Use dictionary to create a sub controller
    private func controller( dict: [String: Any] ) -> UIViewController {
        
        // 1. Get contents of dictionary
        guard let clsName = dict["clsName"] as? String,
            let  title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? SNBaseController.Type,
            let visitorInfoDic = dict["visitorInfo"] as? [String: String]
        else {
            
            return UIViewController()
            
        }
        
        // 2. Create View Controller
        // 1> Transfer clsName to cls
        // 2> Initialize ViewController
        let vc = cls.init()
        
        // Deliver the visitorView data through visitorInfoDic
        vc.visitorInfomation = visitorInfoDic
        
        // 3> Set properties
        // Set title
        vc.title = title
        // Set images
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // Set tabbarItem's color, fontSize
        vc.tabBarItem.setTitleTextAttributes( [NSForegroundColorAttributeName: UIColor.orange],
                                              for: .highlighted)
        vc.tabBarItem.setTitleTextAttributes( [ NSFontAttributeName: UIFont.systemFont(ofSize: 14) ],
                                              for: .normal)
        
        // Will call 'push' when initializing
        let nav = SNNavigationController(rootViewController: vc)
        
        return nav                
        
        
    }
}
