//
//  LoginScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct LoginScreen: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var isPasswordShow: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 4) {
                VStack(alignment: .center,spacing: 8) {
                    Text("ReqRes App")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.accentColor)
                    Text("Login To ResRes App made useing SwiftUI")
                        .font(.footnote)
                }
                .padding(.bottom)
                FloatingLabelTextField(
                    $emailText, placeholder: "Email",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                FloatingLabelTextField(
                    $passwordText, placeholder: "Password",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .rightView({
                        Button(action: {
                            withAnimation {
                                self.isPasswordShow.toggle()
                            }
                            
                        }) {
                            Image(systemName:self.isPasswordShow ? "eye" : "eye")
                        }
                    })
                    .isSecureTextEntry(true)
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                Button(action: {
                    print(emailText)
                    print(passwordText)
                }) {
                    AppButton(buttonText: "Login")
                }
                Spacer()
                NavigationLink(destination: CreateAccountScreen()) {
                    Text("Create Account")
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Login")
        }
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().previewDisplayName("iPhone 11")
    }
}
