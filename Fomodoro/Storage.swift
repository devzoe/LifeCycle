//
//  Storage.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/12/03.
//

import Foundation

public class Storage {
   static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
}
