//
//  ECE564Login.swift
//  ECE564Login
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
import Combine


public struct ECE564Login: View {
    @StateObject private var tabSelection = TabSelection()
    @StateObject private var userSettings = UserSettings()
    @State private var isViewVisible = true
    @State private var authPass: Bool = false
    
    public init() {}
    
    
    public var body: some View {
        if isViewVisible {
            ZStack {
                PaperOnboardingSwiftUIView()
                    .environmentObject(tabSelection)
                
                // Switch Views
                switch tabSelection.currentTab {
                case 0: LoginView().environmentObject(userSettings)
                case 1: UpdateView()
                case 2: StatsView()
                default: LoginView()
                }
            }
            .onAppear {
                if #available(iOS 15.0, *) {
                    Appearance.shared.defaultMode = .light
                } else {
                    UserDefaults.standard.set(false, forKey: "AppleInterfaceStyle")
                }
                userSettings.authString = "InitialValue"
            }
            .onReceive(userSettings.$authString) { newValue in
                isViewVisible = !isViewVisible
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
        }
    }
}


@available(iOS 15.0, *)
class Appearance: ObservableObject {
    static let shared = Appearance()
    
    @Published var defaultMode: AppearanceMode = .unspecified
}

#Preview {
    ECE564Login()
}
