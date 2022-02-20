//
//  CreateAccountScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct CreateAccountScreen: View {
    
    @State private var emailText: String = ""
    @State private var firstName: String = ""
    
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
                    $firstName, placeholder: "Password",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                FloatingLabelTextField(
                    $firstName, placeholder: "Password",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                Button(action: {
                    
                }) {
                    AppButton(buttonText: "Login")
                }
                Spacer()
                NavigationLink(destination: CreateAccountScreen()) {
                  Text("Create Account")
                }
            }
            .padding()
            .navigationTitle("Create Account")
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
