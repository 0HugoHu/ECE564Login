//
//  Error.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import Foundation

enum ErrorType: String {
    case NO_ERROR = ""
    case AUTHENTICATION_FAILED = "Incorrect NetID or Password."
    case NETWORK_ERROR = "No Internet connection."
    case PASSWORD_DUPLICATE = "New password must be different."
    case PASSWORD_DONT_MATCH = "New password doesn't match."
    case SUCCESS = "Password Updated!"
}
