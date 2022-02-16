//
//  LoginScreen.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var emailText: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("ReqRes App")
                .font(.title)
                .fontWeight(.heavy)
            Text("Login To ResRes App made useing SwiftUI")
                .font(.footnote)
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.callout)
                    .bold()
                TextField("Enter username...", text: $emailText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 60)
            }.padding()
            
            HStack {
              Image(systemName: "person").foregroundColor(.gray)
              TextField("Enter your firstName", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
              }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().previewDisplayName("iPhone 11")
    }
}
