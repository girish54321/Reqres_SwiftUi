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
import AlertToast

struct CreateAccountScreen: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var confimPasswordText: String = ""
    @State private var isPasswordShow: Bool = false
    @State private var isValidEmail: Bool = false
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
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
            
            AppButton(text: "Create Account", clicked: {
                if(emailText.isEmpty || passwordText.isEmpty){
                    viewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .error(.red), title: "Email & Password are reqired",subTitle: "plase check error")
                }else{
                    UserCreateAccountApi(email: emailText, password: passwordText)
                }
            })
                .padding(.top,16)
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Create Account")
        .toast(isPresenting: $viewModel.show){
            viewModel.alertToast
        }
    }
    
    // MARK: API Call
    func UserCreateAccountApi(email : String,password : String) {
        viewModel.alertToast = AppMessage.loadindView
        let postdata: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        AF.request("\(AppConst.baseurl)register",method: .post,parameters: postdata).validate().responseDecodable(of: RegisterResponse.self) { (response) in
            if ApiError.checkApiError(response: response.response!){
                guard let data = try? JSONDecoder().decode(RegisterResponse.self, from: response.data! ) else {
                    print("Error: Couldn't decode data into LoginResponse")
                    return
                }
                print(data.token!)
                withAnimation{
                    isLogedIn = true
                }
                viewModel.show = false
            }
        }
    }
}


struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
            .environmentObject(AlertViewModel())
    }
}
