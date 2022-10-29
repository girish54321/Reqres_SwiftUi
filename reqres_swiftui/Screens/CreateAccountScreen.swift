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
    @State private var confirmPasswordText: String = ""
    @State private var isPasswordShow: Bool = false
    // Validation
    @State private var isValidEmail: Bool = false
    @State private var isValidPassword: Bool = false
    @State private var isValidConfirmPassword: Bool = false
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
            .padding(.bottom, 24)
            VStack(spacing: 16){
                AppInputBox(
                    leftIcon:"heart.text.square",
                    rightIcon: isValidEmail ? "checkmark.circle.fill" : "x.circle", placeHoldr: "Email",
                    view: TextField("Email", text: $emailText),
                    keyboard: AppKeyBoardType.emailAddress,
                    state: isValidEmail
                )
                // On Change
                .onChange(of: emailText) { newValue in
                    let result = Helpers.isVaildEmailRegx(text: emailText)
                    withAnimation {
                        isValidEmail = result
                    }
                }
                AppInputBox(
                    leftIcon: "lock",
                    rightIcon: isValidPassword ? "checkmark.circle.fill" : "x.circle",
                    placeHoldr: "Password",
                    passwordView: SecureField("Password", text: $passwordText),
                    state: isValidPassword
                )
                // On change
                .onChange(of: passwordText) { newValue in
                    let result = Helpers.isValidPassword(text: passwordText)
                    withAnimation {
                        isValidPassword = result
                    }
                }
                AppInputBox(
                    leftIcon: "lock",
                    rightIcon: isValidConfirmPassword ? "checkmark.circle.fill" : "x.circle",
                    placeHoldr: "Confirm Password",
                    passwordView: SecureField("Confirm Password", text: $confirmPasswordText),
                    state: isValidConfirmPassword
                )
                // On Change
                .onChange(of: confirmPasswordText) { newValue in
                    let result = Helpers.isValidPassword(text: confirmPasswordText)
                    withAnimation {
                        isValidConfirmPassword = result
                    }
                }
            }
            AppButton(text: "Create Account", clicked: {
                if(emailText.isEmpty || passwordText.isEmpty){
                    viewModel.alertToast = AlertToast(displayMode: .banner(.slide), type: .error(.red), title: "Email & Password are required",subTitle: "please check error")
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
    }
    
    // MARK: API Call
    func UserCreateAccountApi(email : String,password : String) {
        viewModel.alertToast = AppMessage.loadindView
        let postData: [String: Any] = [
            "email" : "eve.holt@reqres.in",
            "password":"cityslicka"
        ]
        AuthServices().createAccount(parameters: postData){
            result in
            switch result {
            case .success(_):
                withAnimation{
                    isLogedIn = true
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    viewModel.toggle()
                    viewModel.errorMessage = errorMessage
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
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
