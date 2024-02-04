//
//  Extension.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import Foundation
import SwiftUI
import Lottie

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


struct LottieViewTA: UIViewRepresentable {
    var animationFileName: String
    let loopMode: LottieLoopMode
    let bundle: Bundle
    
    init(animationFileName: String, loopMode: LottieLoopMode, bundle: Bundle = Bundle.module) {
        self.animationFileName = animationFileName
        self.loopMode = loopMode
        self.bundle = bundle
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        // Update code if needed
    }
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName, bundle: bundle)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}



