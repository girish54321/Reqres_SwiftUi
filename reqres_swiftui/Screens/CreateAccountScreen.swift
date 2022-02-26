//
//  CreateAccountScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import NavigationStack
import Alamofire

struct CreateAccountScreen: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var confimPasswordText: String = ""
    @State private var isPasswordShow: Bool = false
    @State private var isValidEmail: Bool = false
    
    @State private var selection: String? = nil
    
    func checkEmail() -> Bool{
        if(emailText.isValid(.email)){
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            NavigationLink(destination: HomeScreen(), tag: "MainApp", selection: $selection) { EmptyView() }
            VStack(alignment: .center,spacing: 8) {
                Text("ReqRes App")
                    .appTestStyle()
                Text("Create Account with ResRes App")
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
                        .inputIconStyle()
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
                            .inputIconStyle()
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
                        .inputIconStyle()
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
                            .inputIconStyle()
                    }
                })
                .isSecureTextEntry(!self.isPasswordShow)
                .floatingStyle(ThemeTextFieldStyle())
                .frame(height: 70)
            FloatingLabelTextField(
                $confimPasswordText,
                placeholder: "Confim Password",
                editingChanged: { (isChanged) in
                    
                }) {
                }
                .addValidation(.init(condition: emailText.isValid(.password), errorMessage: "Invalid Password"))
                .isShowError(true)
                .errorColor(.red)
                .leftView({
                    Image(systemName:"lock")
                        .inputIconStyle()
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
                            .inputIconStyle()
                    }
                })
                .isSecureTextEntry(!self.isPasswordShow)
                .floatingStyle(ThemeTextFieldStyle())
                .frame(height: 70)
            Button(action: {
                print(emailText)
                print(passwordText)
            }) {
                AppButton(text: "Create Account", clicked: {
                    UserCreateAccountApi(email: emailText, password: passwordText)
                })
            }
            .padding(.top,16)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Create Account")
    }
    
    // MARK: API Call
    func UserCreateAccountApi(email : String,password : String) {
        let postdata: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        AF.request("\(AppConst.baseurl)register",method: .post,parameters: postdata).validate().responseDecodable(of: RegisterResponse.self) { (response) in
            
            if ApiError.checkApiError(response: response.response!) == true {
                guard let data = response.value else {
                    print(response)
                    print("Error")
                    return
                }
                selection = "MainApp"
            }
        }
    }
}


struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
