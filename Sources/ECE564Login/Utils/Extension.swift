//
//  Extension.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        _ content: @autoclosure () -> Content,
        when shouldShow: Bool,
        alignment: Alignment = .leading
    ) -> some View {
        overlay(
            ZStack(alignment: alignment) {
                if shouldShow {
                    content().opacity(shouldShow ? 1 : 0)
                }
                self
            }
        )
    }
}


