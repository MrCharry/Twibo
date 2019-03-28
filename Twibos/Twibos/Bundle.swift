//
//  Bundle.swift
//  Reflection
//
//  Created by 彭韬 on 16/02/2017.
//  Copyright © 2017 Charry Peng. All rights reserved.
//

import Foundation

extension Bundle {
    
    var namespace: String {
        
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
