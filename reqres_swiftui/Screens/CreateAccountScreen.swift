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
//        NavigationView {
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
                    .textModifier()
                FloatingLabelTextField(
                    $firstName, placeholder: "Password",
                    editingChanged: { (isChanged) in
                        
                    }) {
                    }
                    .textModifier()
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "plus.circle")
                        Text("Add new item")
                    }
                    .padding(12)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top)
                }
                Spacer()
                NavigationLink(destination: CreateAccountScreen()) {
                  Text("Create Account")
                }
            }
            .padding()
            .navigationTitle("Create Account")
//        }
//        .navigationTitle("Create Account")
    }
}

struct CreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
