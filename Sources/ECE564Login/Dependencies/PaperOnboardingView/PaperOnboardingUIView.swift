//
//  PaperOnboardingUIView.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
#if canImport(UIKit)
import PaperOnboarding

struct PaperOnboardingSwiftUIView: View {
    static let titleFont = UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont.systemFont(ofSize: 14.0)
    @EnvironmentObject var tabSelection: TabSelection
    
    let items = [
        OnboardingItemInfo(informationImage: loadImage(named: "Empty", withExtension: "png")!,
                           title: "",
                           description: "",
                           pageIcon: loadImage(named: "Check", withExtension: "png")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: loadImage(named: "Empty", withExtension: "png")!,
                           title: "",
                           description: "",
                           pageIcon: loadImage(named: "Compass", withExtension: "png")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: loadImage(named: "Empty", withExtension: "png")!,
                           title: "",
                           description: "",
                           pageIcon: loadImage(named: "Info", withExtension: "png")!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: .white,
                           descriptionColor: .white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
    ]
    
    
    var body: some View {
        PaperOnboardingUIKit(currentTab: $tabSelection.currentTab, items: items).ignoresSafeArea()
            .environmentObject(tabSelection)
    }
}

#Preview {
    PaperOnboardingSwiftUIView()
}

#endif
