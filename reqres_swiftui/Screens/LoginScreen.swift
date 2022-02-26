//
//  LoginScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Alamofire

struct LoginScreen: View {
    
    @State private var emailText: String = "girish@outlook.com"
    @State private var passwordText: String = ""
    @State private var isPasswordShow: Bool = false
    @State private var isValidEmail: Bool = false
    
    @State private var selection: String? = nil
    
    @State private var logedIn = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            NavigationLink(destination: HomeScreen(), tag: "MainApp", selection: $selection) { EmptyView() }
            VStack(alignment: .center,spacing: 8) {
                Text("ReqRes App")
                    .appTestStyle()
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
                        .foregroundColor(checkPassword() ? .green : Color.primary)
                        .animation(.default, value: checkPassword())
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
                AppButton(text: "Login", clicked: {
                    //                       selection = "MainApp"
                    UserLoginApi(email: emailText, password: passwordText)
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
        .alert("User Loged In!", isPresented: $logedIn) {
            Button("OK", role: .cancel) { }
            Button("I know",role: .destructive){ }
        }
    }
    
    
    func checkEmail() -> Bool{
        if(emailText.isValid(.email)){
            return true
        } else {
            return false
        }
    }
    
    func checkPassword() -> Bool{
        if(passwordText.count > 5){
            return true
        } else {
            return false
        }
    }
    
    func UserLoginApi(email : String,password : String) {
        let postdata: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        AF.request("\(AppConst.baseurl)login",method: .post,parameters: postdata).validate().responseJSON { response in
            print(response)
            if ApiError.checkApiError(response: response.response!){
                print(response.data!)
                print("All Doo")
                guard let data = try? JSONDecoder().decode(LoginResponse.self, from: response.data! ) else {
                    print("Error: Couldn't decode data into LoginResponse")
                    return
                }
                print(data.token!)
                selection = "MainApp"
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().previewDisplayName("iPhone 11")
    }
}
