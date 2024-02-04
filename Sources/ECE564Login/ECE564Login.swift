//
//  ECE564Login.swift
//  ECE564Login
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
import Combine


@main
struct ECE564LoginApp: App {
    @StateObject private var tabSelection = TabSelection()
    @StateObject private var userSettings = UserSettings()
    @State private var isViewVisible = true
    @State private var authPass: Bool = false

    var body: some Scene {
        WindowGroup {
            ECE564LoginView()
                .environmentObject(tabSelection)
                .environmentObject(userSettings)
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
        }
    }
}


struct ECE564LoginView: View {
    @EnvironmentObject private var tabSelection: TabSelection
    @EnvironmentObject private var userSettings: UserSettings
    @State private var isViewVisible = true

    var body: some View {
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
            .onReceive(userSettings.$authString) { newValue in
                isViewVisible = !isViewVisible
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
    ECE564LoginView()
}
