//
//  UserPersistence.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import Foundation
import UIKit

@propertyWrapper
struct Defaults<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            /// Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? T else { return defaultValue }
            
            /// Convert data to any datatype
            return data
        }
        set {
            /// Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct UserPersistence: Codable {
    
    @Defaults(key: "likeId", defaultValue: [])
    static var likeId: [Int]
    
}


