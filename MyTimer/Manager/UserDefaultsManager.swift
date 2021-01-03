//
//  UserDefaultsManager.swift
//  MyTimer
//
//  Created by RB on 2021-01-03.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Class Variables
    
    enum Keys {
        @Persist(key: "timerLength", defaultValue: 0)
        static var timerLength: Int
    }
    
    // MARK: - Helper Object
    
    @propertyWrapper
    struct Persist<T> {
        let key: String
        let defaultValue: T
        
        var wrappedValue: T {
            get {
                return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            }
            set {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}
