//
//  LoginScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import Alamofire
import AlertToast

struct LoginScreen: View {
    
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @State private var isPasswordShow: Bool = false
    @State private var isValidEmail: Bool = false
    @State private var isValidPassword : Bool = false
    
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
    @EnvironmentObject var viewModel: AlertViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            VStack(alignment: .center,spacing: 8) {
                Text("ReqRes App")
                    .appTestStyle()
                Text("Login To ResRes App made using SwiftUI")
                    .font(.footnote)
            }
            .padding(.bottom, 24)
            VStack(spacing: 16){
                AppInputBox(
                    leftIcon:"heart.text.square",
                    rightIcon: isValidEmail ? "checkmark.circle.fill" : "x.circle",
                    placeHoldr: "Email",
                    view: TextField("Email", text: $emailText),
                    keyboard: AppKeyBoardType.emailAddress,
                    state: isValidEmail
                )
                .onChange(of: emailText) { newValue in
                    let result = Helpers.isVaildEmailRegx(text: emailText)
                    withAnimation {
                        isValidEmail = result
                        print(isValidEmail)
                    }
                }
                AppInputBox(
                    leftIcon: "lock",
                    rightIcon: isValidPassword ? "checkmark.circle.fill" : "x.circle",
                    placeHoldr: "Password",
                    passwordView: SecureField("Password", text: $passwordText),
                    state: isValidPassword
                )
                .onChange(of: passwordText) { newValue in
                    let result = Helpers.isValidPassword(text: passwordText)
                    withAnimation {
                        isValidPassword = result
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password")
                            .background(
                                Rectangle()
                                    .fill(Color.accentColor)
                                    .frame(height:4)
                                    .cornerRadius(22)
                                    .offset(x: 0, y:14)
                            )
                    }
                }
            }
            AppButton(text: "Login", clicked: {
                if(emailText.isEmpty || passwordText.isEmpty){
                    viewModel.alertToast = AlertToast(
                        displayMode: .banner(.slide),
                        type: .error(.red),
                        title: "Email & Password are required",
                        subTitle: "please check error")
                } else {
                    UserLoginApi(email: emailText, password: passwordText)
                }
            })
            .padding(.top,16)
            Spacer()
            NavigationLink(destination: CreateAccountScreen()) {
                Text("Create Account")
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Login")
        .toast(isPresenting: $viewModel.show){
            viewModel.alertToast
        }
    }
    
    
    func checkEmail() -> Bool {
        if(emailText.isValid(.email)){
            return true
        } else {
            return false
        }
    }
    
    func checkPassword() -> Bool {
        if(passwordText.count > 5){
            return true
        } else {
            return false
        }
    }
    
    func UserLoginApi(email : String,password : String) {
        viewModel.alertToast = AppMessage.loadindView
        let postdata: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        AF.request("\(AppConst.baseurl)login",method: .post,parameters: postdata).validate().responseJSON { response in
            if ApiError.checkApiError(response: response.response!){
                guard let data = try? JSONDecoder().decode(LoginResponse.self, from: response.data! ) else {
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

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().previewDisplayName("iPhone 11")
            .environmentObject(AlertViewModel())
    }
}
