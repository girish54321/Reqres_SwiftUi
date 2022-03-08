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
            .padding(.bottom, 24)
            VStack(spacing: 16){
                AppInputBox(
                    leftIcon:"heart.text.square",
                    rightIcon: "checkmark.circle.fill",
                    placeHoldr: "Email",
                    view: TextField("Email", text: $emailText),
                    keyboard: AppKeyBoardType.emailAddress
                )
                AppInputBox(
                    leftIcon: "lock",
                    rightIcon: "checkmark.circle.fill",
                    placeHoldr: "Password",
                    view: TextField("Password", text: $passwordText),
                    keyboard: AppKeyBoardType.default
                )
                AppInputBox(
                    leftIcon: "lock",
                    rightIcon: "checkmark.circle.fill",
                    placeHoldr: "Confim Password",
                    view: TextField("Confim Password", text: $confimPasswordText),
                    keyboard: AppKeyBoardType.default
                )
            }
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
