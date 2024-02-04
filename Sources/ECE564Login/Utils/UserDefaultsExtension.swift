//
//  UserDefaultsExtension.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/4/24.
//

import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var authString: String? {
        didSet {
            UserDefaults.standard.set(authString, forKey: "AuthString")
        }
    }
}
