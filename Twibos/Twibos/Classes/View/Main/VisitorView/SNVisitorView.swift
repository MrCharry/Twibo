//
//  SNVisitorVIew.swift
//  Twibos
//
//  Created by 彭韬 on 26/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import UIKit

class SNVisitorView: UIView {

    // MARK: - VisitorInfo Dic
    var visitorInfo: [String: String]? {
        didSet{
            
            guard let imgName = visitorInfo?["imgName"],
                  let content = visitorInfo?["content"]
            else {
                    return
            }
            if imgName == "" {
                startAnimation()
                return
            }
            tipLabel.text = content
            houseIcon.image = UIImage.init(named: imgName)
            // The follow view should be hidden in Other view
            icon.isHidden = true
            maskIcon.isHidden = true
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup the animation of Homepage's component
    private func startAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 15
        
        // MARK: - Very IMPORTANT, setup the animation not be destroyed when finishes
        // When the animating component is release, the animation will be destroyed automatically
        animation.isRemovedOnCompletion = false
        icon.layer.add(animation, forKey: nil)
        
    }
    
    
    // Components of the view
    fileprivate var icon: UIImageView = UIImageView( image: UIImage.init(named: "visitordiscover_feed_image_smallicon") )
    
    fileprivate var maskIcon: UIImageView = UIImageView( image: UIImage.init(named: "visitordiscover_feed_mask_smallicon") )
    
    fileprivate var houseIcon: UIImageView = UIImageView( image: UIImage.init(named: "visitordiscover_feed_image_house") )
    
    fileprivate var tipLabel: UILabel = UILabel.cz_label(withText: "Home Page!", fontSize: 14, color: UIColor.darkGray)
    
    fileprivate var registerButton: UIButton = UIButton.cz_textButton("Register", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    fileprivate var loginButton: UIButton = UIButton.cz_textButton("Login", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    
}

// MARK: - Setup View
extension SNVisitorView {
    
    
    func setupUI() {
        
        
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // add Components
        addSubview(icon)
        addSubview(maskIcon)
        addSubview(houseIcon)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // Let the text of Label in the center of view
        tipLabel.textAlignment = .center
        
        // Cancel AutoResizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // MASK: - AutoLayout: the Original layout of Apple
        // Icon
        addConstraint( NSLayoutConstraint(item: icon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0) )
        addConstraint( NSLayoutConstraint(item: icon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60) )
        
        // House Icon
        addConstraint( NSLayoutConstraint(item: houseIcon, attribute: .centerX, relatedBy: .equal, toItem: icon, attribute: .centerX, multiplier: 1.0, constant: 0) )
        addConstraint( NSLayoutConstraint(item: houseIcon, attribute: .centerY, relatedBy: .equal, toItem: icon, attribute: .centerY, multiplier: 1.0, constant: 0) )
        
        // Tip Label
        let margin: CGFloat = 20
        addConstraint( NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: icon, attribute: .centerX, multiplier: 1.0, constant: 0) )
        addConstraint( NSLayoutConstraint(item: tipLabel, attribute: .centerY, relatedBy: .equal, toItem: icon, attribute: .bottom, multiplier: 1.0, constant: margin) )
        addConstraint( NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 236) )
        
        // Register Button
        addConstraint( NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin) )
        addConstraint( NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0) )
        addConstraint( NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100) )
        
        // Login Button
        addConstraint( NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin) )
        addConstraint( NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0) )
        addConstraint( NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: registerButton, attribute: .width, multiplier: 1.0, constant: 0) )
        
        // MADK: - VFL
        // VFL Layout: H/V|-20-[component'name]-val...|
        let viewNameDic = ["maskIcon": maskIcon,
                           "registerButton": registerButton] as [String : Any]
        let metrics = ["marginHeight": -35]
        
        
        addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "H:|-0-[maskIcon]-0-|", options: [], metrics: nil, views: viewNameDic) )
        addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "V:|-0-[maskIcon]-(marginHeight)-[registerButton]", options: [], metrics: metrics, views: viewNameDic) )
        
    }
}
