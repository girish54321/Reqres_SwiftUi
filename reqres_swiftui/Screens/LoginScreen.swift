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
    @State private var isValidEmail: Bool = false
    
    func checkEmail() -> Bool{
        if(emailText.isValid(.email)){
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
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
                    .addValidation(.init(condition: emailText.isValid(.email), errorMessage: "Invalid Email"))
                    .isShowError(true)
                    .errorColor(.red)
                    .leftView({
                        Image(systemName:"heart.text.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(checkEmail() ? .green : Color.primary)
                            .animation(.default, value: checkEmail())
                    })
                    .rightView({
                        Button(action: {
                            withAnimation {
                                self.isPasswordShow.toggle()
                            }
                            
                        }) {
                            Image(systemName: emailText.isValid(.email) ? "checkmark.circle.fill":"exclamationmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .animation(.easeIn(duration: 3), value: checkEmail())
                        }
                    })
                    .floatingStyle(ThemeTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .frame(height: 70)
                    .onChange(of: emailText, perform: { newValue in
                        print(emailText)
                    })
                FloatingLabelTextField(
                    $passwordText, placeholder: "Password",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .addValidation(.init(condition: emailText.isValid(.password), errorMessage: "Invalid Password"))
                    .isShowError(true)
                    .errorColor(.red)
                    .leftView({
                        Image(systemName:"lock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(checkEmail() ? .green : Color.primary)
                            .animation(.default, value: checkEmail())
                    })
                    .rightView({
                        Button(action: {
                            withAnimation {
                                self.isPasswordShow.toggle()
                            }
                            
                        }) {
                            Image(systemName:self.isPasswordShow ? "eye.slash" : "eye.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    })
                    .isSecureTextEntry(!self.isPasswordShow)
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                Button(action: {
                    print(emailText)
                    print(passwordText)
                }) {
                    AppButton(text: "Login",clicked: {
                        withAnimation {
                            self.isPasswordShow.toggle()
                            isValidEmail = checkEmail()
                        }
                    })
                }
                .padding(.top,16)
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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().previewDisplayName("iPhone 11")
    }
}
