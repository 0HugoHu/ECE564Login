//
//  File.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
import Foundation
import PaperOnboarding

struct PaperOnboardingUIKit: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    @Binding var currentTab: Int
    
    var items: [OnboardingItemInfo]
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        // Init PaperOnboarding
        let onboarding = PaperOnboarding()
        onboarding.delegate = context.coordinator
        onboarding.dataSource = context.coordinator
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        
        controller.view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding, attribute: attribute, relatedBy: .equal, toItem: controller.view, attribute: attribute, multiplier: 1, constant: 0)
            controller.view.addConstraint(constraint)
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Implement if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, currentTab: $currentTab)
    }
    
    class Coordinator: NSObject, PaperOnboardingDataSource, PaperOnboardingDelegate {
        var parent: PaperOnboardingUIKit
        @Binding var currentTab: Int
        
        init(parent: PaperOnboardingUIKit, currentTab: Binding<Int>) {
            self.parent = parent
            self._currentTab = currentTab
        }
        
        // MARK: - PaperOnboardingDataSource
        
        func onboardingItem(at index: Int) -> OnboardingItemInfo {
            return parent.items[index]
        }
        
        func onboardingItemsCount() -> Int {
            return parent.items.count
        }
        
        // MARK: - PaperOnboardingDelegate
        
        func onboardingWillTransitonToIndex(_ index: Int) {
            // Handle transition to index
        }
        
        @objc func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
            // Setup Labels
            // item.titleLabel?.textColor = .white
            // item.descriptionLabel?.textColor = .white
            
            // Rounded Image
            // item.imageView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            // item.imageView?.layer.cornerRadius = 100
            // item.imageView?.layer.masksToBounds = true
            // item.imageView?.contentMode = .scaleToFill
            DispatchQueue.main.async {
                self.currentTab = index
            }
        }
    }
}

#endif
