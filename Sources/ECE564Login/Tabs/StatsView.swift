//
//  StatsView.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
import SwiftfulLoadingIndicators
import Combine

struct StatsView: View {
    @State private var isViewVisible = false
    @StateObject private var dataModel = DukePersonDictTA()
    @State private var isLoading: Bool = true
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                if !isLoading {
                    DukeStatsView()
                        .environmentObject(dataModel)
                } else {
                    LoadingIndicator(animation: .pulse, color: .white, size: .large, speed: .normal)
                    
                    Text("Loading")
                        .font(titleFontDefaultSize).foregroundColor(.white)
                }
            }
            .frame(width: width, height: height * 0.93)
        }
        .onAppear {
            if dataModel.download() {
                cancellable = Timer.publish(every: 2.0, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        isLoading = !(dataModel.downloadProgress == 1.0)
                        if isLoading == false {
                            cancellable?.cancel()
                        }
                    }
            }
        }
    }
}

#Preview {
    StatsView()
        .background(Color(red: 0.61, green: 0.56, blue: 0.74))
}
