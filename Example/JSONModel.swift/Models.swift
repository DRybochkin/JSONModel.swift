//
//  Models.swift
//  JSONModel.swift
//
//  Created by Dmitry Rybochkin on 21.03.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import JSONModel_swift

class SimpleModel: JSONModel {
    var amount: NSNumber = 0
    var count: Int = 0
    var dueDate: Date = Date()
    var title: String = ""
}

class FullModel: JSONModel {
    var id: Int = 0
    var optionalId: Int64?
    var optionalDefaultId: Int64!
    var enumVar: NamePropertyMapRules = NamePropertyMapRules.None
    var optionalEnum: NamePropertyMapRules?
    var optionalDefaultEnum: NamePropertyMapRules!
    var mappedId: Int = 0
    var mappedOptionalId: Int64!
    var objectModel: SimpleModel = SimpleModel(json: "")
    var objectOptionalModel: SimpleModel!
    var stringArray: [String] = []
    var optionalDefaultArray: [String]!
    var objectArray: [SimpleModel] = []
    var optionalDefaultObjectArray: [SimpleModel]!
    var dictionary: [String] = []
    var optionalDefaultDictionary: [String]!
    var objectDictionary: [String: SimpleModel] = [:]
    var optionalDefaultObjectDictionary: [String: SimpleModel]!
    
    override func willPropertyChanged(_ value: Any, _ property: SerializeProperty) -> Bool {
        if (property.name == "optionalId") {
            optionalId = value as? Int64
        } else if (property.name == "optionalDefaultId") {
            optionalDefaultId = value as? Int64
        } else if (property.name == "enumVar") {
            enumVar = value as! NamePropertyMapRules
        } else if (property.name == "optionalEnum") {
            enumVar = value as! NamePropertyMapRules
        } else if (property.name == "optionalDefaultEnum") {
            enumVar = value as! NamePropertyMapRules
        } else if (property.name == "") {
        } else {
            return false
        }
        return true
    }
}
