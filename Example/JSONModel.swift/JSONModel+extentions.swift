//
//  JSONModel+extentions.swift
//  JSONModel.swift
//
//  Created by Dmitry Rybochkin on 21.03.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import JSONModel_swift

extension JSONModel {
    open func stringToNamePropertyMapRules(_ value: String) -> Any {
        return NamePropertyMapRules(rawValue: Int(value)!)!
    }
    
    open func numberToNamePropertyMapRules(_ value: NSNumber) -> Any {
        return NamePropertyMapRules(rawValue: value.intValue)!
    }
}

