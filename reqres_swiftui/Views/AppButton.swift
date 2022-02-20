//
//  AppButton.swift
//  reqres_swiftui
//
//  Created by Apple on 17/02/22.
//

import SwiftUI

struct AppButton: View {
    
    var buttonText: String
    
    var body: some View {
        HStack {
            Text(buttonText)
                .padding(.horizontal,22)
        }
        .padding(12)
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(8)
        .padding(.top)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(buttonText: "Demo")
    }
}
