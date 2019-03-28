//
//  SNDemoController.swift
//  Twibos
//
//  Created by 彭韬 on 24/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit

class SNDemoController: SNBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @objc fileprivate func showNext() {
        
        let vc = SNDemoController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SNDemoController {
    
    override func setupUI() {
        super.setupUI()
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem( title: "Next", style: .plain, target: self, action: #selector(showNext) )
//        
//        let btn: UIButton = UIButton.cz_textButton("Next", fontSize: 16, normalColor: UIColor.gray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showNext), for: .touchUpInside)
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        navItem.rightBarButtonItem = UIBarButtonItem( title: "Next", fontSize: 16, target: self, action: #selector(showNext) )
        
        
    }
}
