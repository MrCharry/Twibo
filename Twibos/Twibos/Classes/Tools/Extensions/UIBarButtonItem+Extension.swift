//
//  UIBarButtonItem+Extension.swift
//  Twibos
//
//  Created by 彭韬 on 24/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    /// Create UIBarButtonItem
    /// Parameter: title: String - title
    
    
    convenience init(title: String, fontSize: CGFloat=16, target: Any?, action: Selector, isBack: Bool=false) {
        
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: UIColor.gray, highlightedColor: UIColor.orange)
        
        if isBack {
            
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage.init(named: imageName), for: .normal)
            btn.setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
}
