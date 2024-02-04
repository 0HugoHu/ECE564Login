//
//  UserAuth.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/4/24.
//

import Foundation

struct UserAuth: Codable{
    var id: UUID?
    var username: String
    var password: String?
    var userType: UserType
}

enum UserType: String, Codable{
    case Professor
    case TA
    case Student
    case Other
}
