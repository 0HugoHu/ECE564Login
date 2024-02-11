//
//  LoginView.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
import LoadingButton

struct LoginView: View {
    @State private var netID: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var isViewVisible = false
    @State private var isError: ErrorType = .NO_ERROR
    @EnvironmentObject private var userSettings: UserSettings
    @StateObject private var dataModel: DukePersonDictTA = DukePersonDictTA()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let buttonStyle = LoadingButtonStyle(
                width: width * 0.6,
                cornerRadius: 8,
                backgroundColor: Color(red: 0.20, green: 0.49, blue: 0.81),
                loadingColor: Color(red: 0.20, green: 0.49, blue: 0.81).opacity(0.75),
                strokeWidth: 5,
                strokeColor: .white
            )
            
            VStack {
                LottieViewTA(animationFileName: "Animation-Tab1", loopMode: .loop)
                    .frame(width: width * 0.75, height: width * 0.75)
                    .overlay(
                        VStack {
                            FadeInOutView(text: "ECE564", startTime: 0.1)
                                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                            FadeInOutView(text: "Login", startTime: 0.5)
                                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        }
                    )
                
                VStack {
                    TextField(
                        "",
                        text: $netID
                    )
                    .placeholder(Text("NetID").foregroundColor(.white), when: netID.isEmpty)
                    .frame(minHeight: width * 0.1)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .padding([.horizontal], 8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
                    .padding(.vertical)
                    
                    SecureField(
                        "",
                        text: $password
                    )
                    .placeholder(Text("Password").foregroundColor(.white), when: password.isEmpty)
                    .frame(minHeight: width * 0.1)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .padding([.horizontal], 8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
                    
                    Text(isError.rawValue)
                        .foregroundColor(Color(red: 0.79, green: 0.0, blue: 0.0))
                        .opacity(isError == .NO_ERROR ? 0.0 : 1.0)
                        .padding(.top, 16)
                    
                    LoadingButton(action: submitAction, isLoading: $isLoading, style: buttonStyle) {
                        Text("Log in").foregroundColor(Color.white).font(titleFontDefaultSize)
                    }
                    .frame(height: width * 0.3)
                    .padding()
                }
                .frame(width: width * 0.6)
            }
            .frame(width: width, height: geometry.size.height)
        }
        .opacity(isViewVisible ? 1 : 0)
        .animation(.easeIn(duration: 1), value: isViewVisible)
        .onAppear {
            isViewVisible = true
            _ = dataModel.download()
        }
    }
    
    
    private func submitAction() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        isError = .NO_ERROR
        guard dataModel.downloadProgress == 1.0 else {
            DispatchQueue.main.async {
                isError = .NETWORK_ERROR
                isLoading = false
            }
            return
        }
        
        guard let DUID = dataModel.find(netID: netID), DUID != -1 else {
            DispatchQueue.main.async {
                isError = .AUTHENTICATION_FAILED
                isLoading = false
            }
            return
        }
        
        guard dataModel.upload(website: defaultUrlString, auth: String(netID + ":" + password), update: true, id: netID, duid: DUID) else {
            DispatchQueue.main.async {
                isError = .AUTHENTICATION_FAILED
                isLoading = false
            }
            return
        }
        
        let timeoutInSeconds: TimeInterval = 3.0
        var elapsedTime: TimeInterval = 0.0
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard dataModel.uploadDone == 1 else {
                if dataModel.uploadDone < 0 {
                    DispatchQueue.main.async {
                        isError = .AUTHENTICATION_FAILED
                        isLoading = false
                    }
                } else {
                    elapsedTime += 1.0
                    if elapsedTime >= timeoutInSeconds {
                        DispatchQueue.main.async {
                            isError = .AUTHENTICATION_FAILED
                            isLoading = false
                        }
                        timer.invalidate()
                    }
                }
                return
            }
            
            userSettings.authString = String(netID + ":" + password)
            timer.invalidate()
        }
        
        RunLoop.main.add(timer, forMode: .common)
        
        elapsedTime += 1.0
        if elapsedTime >= timeoutInSeconds {
            DispatchQueue.main.async {
                isError = .AUTHENTICATION_FAILED
                isLoading = false
            }
            timer.invalidate()
        }
    }
}


#Preview {
    VStack {
        LoginView()
    }
    .background(Color(red: 0.40, green: 0.56, blue: 0.71))
}
