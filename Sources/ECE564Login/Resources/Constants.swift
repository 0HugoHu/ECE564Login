//
//  Constants.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

let titleFont = loadCustomFont(name: "Nunito-Bold", extension: "ttf", size: 36.0)
let titleFontDefaultSize = loadCustomFont(name: "Nunito-Regular", extension: "ttf", size: 24.0)
let descriptionFont = loadCustomFont(name: "OpenSans-Regular", extension: "ttf", size: 14.0)

let fakeAuth = "fakeid:2f25a07a36561c89d5f1887c851b2330cacd5d80f3e99ab25eaee6cd593e77e9"
//let fakeAuth = "fakeid:7a97119d7cb3ef28d263428116b04867b1c9c9897f740f480a62bc3c3da78384"


let junkString = "asdowapegonapwoiengpoiwnpoiawnepofnawpoienfopiwaemfoiwamepfoiwnpgoiw"

let domainString = "http://ece564.rc.duke.edu:8080/"
//let domainString = "http://localhost:8080/"
let defaultUrlString = domainString + "entries"
let changePasswordUrlString = domainString + "user"

#endif
