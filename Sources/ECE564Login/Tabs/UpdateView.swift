//
//  UpdateView.swift
//  PasswordManager
//
//  Created by Hugooooo on 2/3/24.
//

import SwiftUI
import LoadingButton

struct UpdateView: View {
    @State private var netID: String = ""
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var newPasswordConfirm: String = ""
    @State private var isLoading: Bool = false
    @State private var isViewVisible = false
    @State private var isError: ErrorType = .NO_ERROR
    @StateObject private var dataModel: DukePersonDictTA = DukePersonDictTA()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let buttonStyle = LoadingButtonStyle(
                width: width * 0.6,
                cornerRadius: 8,
                backgroundColor: Color(red: 0.20, green: 0.59, blue: 0.55),
                loadingColor: Color(red: 0.20, green: 0.59, blue: 0.55).opacity(0.75),
                strokeWidth: 5,
                strokeColor: .white
            )
            
            VStack {
                LottieView(animationFileName: "Animation-Tab2", loopMode: .loop)
                    .frame(width: width * 0.75, height: width * 0.75)
                    .overlay(
                        VStack {
                            FadeInOutView(text: "Change", startTime: 0.1)
                                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                            FadeInOutView(text: "Password", startTime: 0.5)
                                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                        }
                    )
                
                VStack {
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
                        .padding(.vertical, 4)
                        
                        
                        SecureField(
                            "",
                            text: $password
                        )
                        .placeholder(Text("Old Password").foregroundColor(.white), when: password.isEmpty)
                        .frame(minHeight: width * 0.1)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .padding([.horizontal], 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
                        .padding(.vertical, 4)
                        
                        
                        SecureField(
                            "",
                            text: $newPassword
                        )
                        .placeholder(Text("New Password").foregroundColor(.white), when: newPassword.isEmpty)
                        .frame(minHeight: width * 0.1)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .padding([.horizontal], 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
                        .padding(.vertical, 4)
                        
                        
                        SecureField(
                            "",
                            text: $newPasswordConfirm
                        )
                        .placeholder(Text("Confirm Password").foregroundColor(Color.white), when: newPasswordConfirm.isEmpty)
                        .frame(minHeight: width * 0.1)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .textFieldStyle(PlainTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .padding([.horizontal], 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
                        .padding(.vertical, 4)
                    }
                    .frame(width: width * 0.6)
                    
                    Text(isError.rawValue)
                        .foregroundColor(isError == .SUCCESS ? Color(red: 0.0, green: 0.0, blue: 0.79) : Color(red: 0.79, green: 0.0, blue: 0.0))
                        .opacity(isError == .NO_ERROR ? 0.0 : 1.0)
                        .padding(.top, 8)
                    
                    LoadingButton(action: submitAction, isLoading: $isLoading, style: buttonStyle) {
                        Text("Submit").foregroundColor(Color.white).font(titleFontDefaultSize)
                    }
                    .frame(height: width * 0.25)
                }
            }
            .frame(width: width, height: geometry.size.height)
        }
        .opacity(isViewVisible ? 1 : 0)
        .animation(.easeIn(duration: 1), value: isViewVisible)
        .onAppear {
            isViewVisible = true
            // I know this loads every time when switching tabs
            _ = dataModel.download()
        }
    }
    
    
    private func submitAction() {
        DispatchQueue.main.async {
            isError = .NO_ERROR
            guard newPassword == newPasswordConfirm else {
                isError = .PASSWORD_DONT_MATCH
                isLoading = false
                return
            }
            
            guard newPassword != password else {
                isError = .PASSWORD_DUPLICATE
                isLoading = false
                return
            }
            
            guard dataModel.downloadProgress == 1.0 else {
                isError = .NETWORK_ERROR
                isLoading = false
                return
            }
            
            guard let DUID = dataModel.find(netID: netID), DUID != -1 else {
                isError = .AUTHENTICATION_FAILED
                isLoading = false
                return
            }
            
            guard dataModel.upload(website: defaultUrlString, auth: String(netID + ":" + password), update: true, id: netID, duid: DUID) else {
                isError = .AUTHENTICATION_FAILED
                isLoading = false
                return
            }
        }
        
        let timeoutInSeconds: TimeInterval = 2.0
        var elapsedTime: TimeInterval = 0.0
        var elapsedTime2: TimeInterval = 0.0
        
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
            
            guard dataModel.changePassword(netID: netID, auth: String(netID + ":" + password), newPassword: newPassword) else {
                DispatchQueue.main.async {
                    isError = .AUTHENTICATION_FAILED
                    isLoading = false
                }
                timer.invalidate()
                return
            }
            
            let timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer2 in
                guard dataModel.uploadDone == 1 else {
                    if dataModel.uploadDone < 0 {
                        DispatchQueue.main.async {
                            isError = .AUTHENTICATION_FAILED
                            isLoading = false
                        }
                    } else {
                        elapsedTime2 += 1.0
                        if elapsedTime2 >= timeoutInSeconds {
                            DispatchQueue.main.async {
                                isError = .AUTHENTICATION_FAILED
                                isLoading = false
                            }
                            timer2.invalidate()
                        }
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    isError = .SUCCESS
                    isLoading = false
                }
                timer2.invalidate()
            }
            
            RunLoop.main.add(timer2, forMode: .common)
            timer.invalidate()
        }
        
        RunLoop.main.add(timer, forMode: .common)
    }
}


#Preview {
    VStack {
        UpdateView()
    }
    .background(Color(red: 0.40, green: 0.69, blue: 0.71))
}
