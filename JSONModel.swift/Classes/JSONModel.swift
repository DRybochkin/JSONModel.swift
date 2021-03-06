//
//  DataModels.swift
//  FamilyBudget
//
//  Created by Dmitry Rybochkin on 17.01.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum NamePropertyMapRules: Int {
    case
        None = 0,
        IgnoringCase = 1,
        FirstSymbolToUpper = 2,
        FirstSymbolToLower = 3
}

open class JSONModel: NSObject, Reflectable {
    public var keyMapper: [String: String]! {
        get {
            return [:]
        }
    }
    
    public var namePropertyRule: NamePropertyMapRules = NamePropertyMapRules.IgnoringCase
    
    private func valueTo(_ value: Any?, _ property: SerializeProperty) -> Any? {
        if (value is NSNumber) {
            return numberTo(value as? NSNumber, property)
        } else if (value is String) {
            return stringTo(value as? String, property)
        } else if (value is Bool) {
            return boolTo(value as? Bool, property)
        } else if (value is NSNull) {
            return nullTo(value, property)
        } else if (value is [Any]) {
            return arrayTo(value as? [Any], property)
        } else if (value is [AnyHashable: Any]) {
            return dictionaryTo(value as? [AnyHashable: Any], property)
        } else {
        }
        return value
    }

    private func arrayTo(_ value: [Any]?, _ property: SerializeProperty) -> [Any]? {
        let type = property.type
        if (type is Array<Any>.Type) {
            return value
        } else {
            let sel: Selector = Selector(String(format: "arrayTo%@%@", String(describing: type), ":"))
            if (responds(to: sel)) {
                let res = perform(sel, with: value)
                return res?.takeRetainedValue() as? [Any]
            }
        }
        return nil
    }

    private func dictionaryTo(_ value: [AnyHashable: Any]?, _ property: SerializeProperty) -> [AnyHashable: Any]? {
        let type = property.type
        if (type is Dictionary<AnyHashable, Any>.Type) {
            return value
        } else {
            let sel: Selector = Selector(String(format: "dictionaryTo%@%@", String(describing: type), ":"))
            if (responds(to: sel)) {
                let res = perform(sel, with: value)
                return res?.takeRetainedValue() as? [AnyHashable: Any]
            }
        }
        return nil
    }

    private func unknownTo(_ value: Any?, _ property: SerializeProperty) -> Any? {
        let sel: Selector = Selector(String(format: "unknownTo%@%@", String(describing: property.type), ":"))
        if (responds(to: sel)) {
            return perform(sel, with: value)
        }
        return nil
    }
    
    private func nullTo(_ value: Any?, _ property: SerializeProperty) -> Any? {
        return nil
    }
    
    private func boolTo(_ value: Bool?, _ property: SerializeProperty) -> Any? {
        let type = property.type
        if (type is Int.Type || type is ImplicitlyUnwrappedOptional<Int>.Type || type is Optional<Int>.Type) {
            return Int(value! ? 1 : 0)
        } else if (type is Int64.Type || type is ImplicitlyUnwrappedOptional<Int64>.Type || type is Optional<Int64>.Type) {
            return Int64(value! ? 1 : 0)
        } else if (type is Int8.Type || type is ImplicitlyUnwrappedOptional<Int8>.Type || type is Optional<Int8>.Type) {
            return Int8(value! ? 1 : 0)
        } else if (type is Int16.Type || type is ImplicitlyUnwrappedOptional<Int16>.Type || type is Optional<Int16>.Type) {
            return Int16(value! ? 1 : 0)
        } else if (type is Int32.Type || type is ImplicitlyUnwrappedOptional<Int32>.Type || type is Optional<Int32>.Type) {
            return Int32(value! ? 1 : 0)
        } else if (type is Double.Type || type is ImplicitlyUnwrappedOptional<Double>.Type || type is Optional<Double>.Type) {
            return Double(value! ? 1 : 0)
        } else if (type is Float.Type || type is ImplicitlyUnwrappedOptional<Float>.Type || type is Optional<Float>.Type) {
            return Float(value! ? 1 : 0)
        } else if (type is Float32.Type || type is ImplicitlyUnwrappedOptional<Float32>.Type || type is Optional<Float32>.Type) {
            return Float32(value! ? 1 : 0)
        } else if (type is Float64.Type || type is ImplicitlyUnwrappedOptional<Float64>.Type || type is Optional<Float64>.Type) {
            return Float64(value! ? 1 : 0)
        } else if (type is Float80.Type || type is ImplicitlyUnwrappedOptional<Float80>.Type || type is Optional<Float80>.Type) {
            return Float80(value! ? 1 : 0)
        } else if (type is NSNumber.Type || type is ImplicitlyUnwrappedOptional<NSNumber>.Type || type is Optional<NSNumber>.Type) {
            return NSNumber.init(value: value!)
        } else if (type is String.Type || type is ImplicitlyUnwrappedOptional<String>.Type || type is Optional<String>.Type) {
            return value! ? "true" : "false"
        } else if (type is Bool.Type || type is ImplicitlyUnwrappedOptional<Bool>.Type || type is Optional<Bool>.Type) {
            return value
        } else if (type is Date.Type || type is ImplicitlyUnwrappedOptional<Date>.Type || type is Optional<Date>.Type) {
            return nil
        } else {
            let sel: Selector = Selector(String(format: "boolTo%@%@", String(describing: type), ":"))
            if (responds(to: sel)) {
                return perform(sel, with: value)
            }
        }
        return value
    }

    private func numberTo(_ value: NSNumber?, _ property: SerializeProperty) -> Any? {
        let type = property.type
        if (type is Int.Type || type is ImplicitlyUnwrappedOptional<Int>.Type || type is Optional<Int>.Type) {
            return value?.intValue
        } else if (type is Int64.Type || type is ImplicitlyUnwrappedOptional<Int64>.Type || type is Optional<Int64>.Type) {
            return value?.int64Value
        } else if (type is Int8.Type || type is ImplicitlyUnwrappedOptional<Int8>.Type || type is Optional<Int8>.Type) {
            return value?.int8Value
        } else if (type is Int16.Type || type is ImplicitlyUnwrappedOptional<Int16>.Type || type is Optional<Int16>.Type) {
            return value?.int16Value
        } else if (type is Int32.Type || type is ImplicitlyUnwrappedOptional<Int32>.Type || type is Optional<Int32>.Type) {
            return value?.int32Value
        } else if (type is Double.Type || type is ImplicitlyUnwrappedOptional<Double>.Type || type is Optional<Double>.Type) {
            return value?.doubleValue
        } else if (type is Float.Type || type is ImplicitlyUnwrappedOptional<Float>.Type || type is Optional<Float>.Type) {
            return value?.floatValue
        } else if (type is Float32.Type || type is ImplicitlyUnwrappedOptional<Float32>.Type || type is Optional<Float32>.Type) {
            return Float32(value!)
        } else if (type is Float64.Type || type is ImplicitlyUnwrappedOptional<Float64>.Type || type is Optional<Float64>.Type) {
            return Float64(value!)
        } else if (type is Float80.Type || type is ImplicitlyUnwrappedOptional<Float80>.Type || type is Optional<Float80>.Type) {
            return Float80((value?.floatValue)!)
        } else if (type is NSNumber.Type || type is ImplicitlyUnwrappedOptional<NSNumber>.Type || type is Optional<NSNumber>.Type) {
            return value
        } else if (type is String.Type || type is ImplicitlyUnwrappedOptional<String>.Type || type is Optional<String>.Type) {
            return value?.stringValue
        } else if (type is Bool.Type || type is ImplicitlyUnwrappedOptional<Bool>.Type || type is Optional<Bool>.Type) {
            return value?.boolValue
        } else if (type is Date.Type || type is ImplicitlyUnwrappedOptional<Date>.Type || type is Optional<Date>.Type) {
            return Date(timeIntervalSince1970: TimeInterval((value?.intValue)!))
        } else {
            let sel: Selector = Selector(String(format: "numberTo%@%@", String(describing: type), ":"))
            if (responds(to: sel)) {
                return perform(sel, with: value)
            }
        }
        return value
    }

    private func stringTo(_ value: String?, _ property: SerializeProperty) -> Any? {
        let type = property.type
        if (type is Int.Type || type is ImplicitlyUnwrappedOptional<Int>.Type || type is Optional<Int>.Type) {
            return Int(value!)
        } else if (type is Int64.Type || type is ImplicitlyUnwrappedOptional<Int64>.Type || type is Optional<Int64>.Type) {
            return Int64(value!)
        } else if (type is Int8.Type || type is ImplicitlyUnwrappedOptional<Int8>.Type || type is Optional<Int8>.Type) {
            return Int8(value!)
        } else if (type is Int16.Type || type is ImplicitlyUnwrappedOptional<Int16>.Type || type is Optional<Int16>.Type) {
            return Int16(value!)
        } else if (type is Int32.Type || type is ImplicitlyUnwrappedOptional<Int32>.Type || type is Optional<Int32>.Type) {
            return Int32(value!)
        } else if (type is Double.Type || type is ImplicitlyUnwrappedOptional<Double>.Type || type is Optional<Double>.Type) {
            return Double(value!)
        } else if (type is Float.Type || type is ImplicitlyUnwrappedOptional<Float>.Type || type is Optional<Float>.Type) {
            return Float(value!)
        } else if (type is Float32.Type || type is ImplicitlyUnwrappedOptional<Float32>.Type || type is Optional<Float32>.Type) {
            return Float32(value!)
        } else if (type is Float64.Type || type is ImplicitlyUnwrappedOptional<Float64>.Type || type is Optional<Float64>.Type) {
            return Float64(value!)
        } else if (type is Float80.Type || type is ImplicitlyUnwrappedOptional<Float80>.Type || type is Optional<Float80>.Type) {
            return Float80(value!)
        } else if (type is NSNumber.Type || type is ImplicitlyUnwrappedOptional<NSNumber>.Type || type is Optional<NSNumber>.Type) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            numberFormatter.usesGroupingSeparator = false
            numberFormatter.currencyDecimalSeparator = NSLocale.current.decimalSeparator
            
            var str = value?.replacingOccurrences(of: ".", with: NSLocale.current.decimalSeparator!)
            str = str?.replacingOccurrences(of: ",", with: NSLocale.current.decimalSeparator!)
            
            var strArray = str?.components(separatedBy: CharacterSet(charactersIn: "0123456789" + NSLocale.current.decimalSeparator!).inverted)
            var found = true
            let count: Int = (strArray?.count)!
            for i in 0 ..< count {
                if (strArray?[i] == NSLocale.current.decimalSeparator) {
                    if (found) {
                        strArray?[i] = ""
                    }
                    found = false
                }
            }
            str = strArray?.joined(separator: "")
            return numberFormatter.number(from: str!)
        } else if (type is String.Type || type is ImplicitlyUnwrappedOptional<String>.Type || type is Optional<String>.Type) {
            return value
        } else if (type is Bool.Type || type is ImplicitlyUnwrappedOptional<Bool>.Type || type is Optional<Bool>.Type) {
            return (value == "true" || value == "YES") ? true : false
        } else if (type is Date.Type || type is ImplicitlyUnwrappedOptional<Date>.Type || type is Optional<Date>.Type) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZZ"
            return dateFormatter.date(from: value!)
        } else {
            let sel: Selector = Selector(String(format: "stringTo%@%@", String(describing: type), ":"))
            if (responds(to: sel)) {
                return perform(sel, with: value)
            }
        }
        return value
    }
    
    private func capitalizeFirst(_ string: String, upperCase: Bool = true) -> String {
        if (string.characters.count > 0) {
            var firstCharacter = String(string.characters.first!)
            if (upperCase){
                firstCharacter = firstCharacter.uppercased()
            } else {
                firstCharacter = firstCharacter.lowercased()
            }

            return string.replacingCharacters(in: string.startIndex ..< string.index(after: string.startIndex), with: firstCharacter)
        }
        return string
    }
    
    open func willPropertyChanged(_ value: Any, _ property: SerializeProperty) -> Bool {
        return false
    }
    
    open func setCustomValue(_ value: Any, _ property: SerializeProperty) {
        if (!willPropertyChanged(value, property)) {
            super.setValue(value, forKey: property.name)
        }
    }
    
    public init!(json: JSON?) {
        super.init()
        if (json != nil) {
            let map = keyMapper!
            for property in properties() {
                var propertyName = property.name
                var found: Bool = false
                
                if (namePropertyRule == .IgnoringCase) {
                    if (map.keys.contains(property.name)) {
                        propertyName = map[property.name]!
                    }
                    found = (json?.dictionaryObject?.keys.contains { (elem: String) -> Bool in
                        if (elem.lowercased() == propertyName.lowercased()) {
                            propertyName = elem
                            return true
                        }
                        return false
                    })!
                } else if (namePropertyRule == .FirstSymbolToUpper) {
                    if (map.keys.contains(property.name)) {
                        propertyName = map[property.name]!
                    }
                    found = (json?.dictionaryObject?.keys.contains { (elem: String) -> Bool in
                        if (elem == capitalizeFirst(propertyName)) {
                            propertyName = elem
                            return true
                        }
                        return false
                        })!
                } else if (namePropertyRule == .FirstSymbolToLower) {
                    if (map.keys.contains(property.name)) {
                        propertyName = map[property.name]!
                    }
                    found = (json?.dictionaryObject?.keys.contains { (elem: String) -> Bool in
                        if (elem == capitalizeFirst(propertyName, upperCase: false)) {
                            propertyName = elem
                            return true
                        }
                        return false
                        })!
                } else if (namePropertyRule == .None) {
                    if (map.keys.contains(property.name)) {
                        propertyName = map[property.name]!
                    }
                    found = (json?.dictionaryObject?.keys.contains(propertyName))!
                }
                if (found) {
                    if (json?[propertyName].type == .number) {
                        let convertedValue = valueTo(json?[propertyName].number, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .string) {
                        let convertedValue = valueTo(json?[propertyName].stringValue, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .bool) {
                        let convertedValue = valueTo(json?[propertyName].boolValue, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .array) {
                        let convertedValue = valueTo(json?[propertyName].arrayValue, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .dictionary) {
                        let convertedValue = valueTo(json?[propertyName].dictionaryValue, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .null) {
                        let convertedValue = valueTo(json?[propertyName].null, property)!
                        setCustomValue(convertedValue, property)
                    } else if (json?[propertyName].type == .unknown) {
                        let convertedValue = valueTo(json?[propertyName].object, property)!
                        setCustomValue(convertedValue, property)
                    }
                }
            }
        }
    }

    func properties()->[SerializeProperty]{
        return Mirror(reflecting: self).toArray()
    }
    
    func NumberToInt64(_ value: NSNumber) -> Int64 {
        return value.int64Value
    }

    func NumberToInt(_ value: NSNumber) -> Int {
        return value.intValue
    }

    func StringToInt64(_ value: String) -> Int64 {
        return Int64(value)!
    }
    
    func StringToInt(_ value: String) -> Int {
        return Int(value)!
    }

    func StringToString(_ value: String) -> String {
        return value
    }
}

protocol Reflectable {
    func properties()->[SerializeProperty]
}

open class SerializeProperty {
    public var name: String = ""
    public var type: Any.Type = String.Type.self
    
    public init(name: String, type: Any.Type) {
        self.name = name
        self.type = type
    }
}

extension Mirror {
    func toArray() -> [SerializeProperty] {
        var result = [SerializeProperty]()
        
        // Properties of this instance:
        for property in self.children {
            if let propertyName = property.label {
                result.append(SerializeProperty(name: propertyName, type: type(of: property.value)))
            }
        }
        
        // Add properties of superclass:
        if let parent = self.superclassMirror {
            for propertyName in parent.toArray() {
                result.append(propertyName)
            }
        }
        
        return result
    }
}


