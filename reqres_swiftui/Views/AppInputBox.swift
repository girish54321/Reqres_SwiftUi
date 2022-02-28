//
//  AppInputBox.swift
//  reqres_swiftui
//
//  Created by Apple on 28/02/22.
//

import SwiftUI

struct AppInputBox: View {
    
    //    @State var emailText @State
    //    var leftIcon: Image?
    @State var text: String = "projectedValue"
    var leftIcon: String?
    var rightIcon: String?
    var placeHoldr: String
    
    var body: some View {
        VStack {
            HStack (spacing:8) {
                if leftIcon != nil {
                    Image(systemName:leftIcon!)
                        .inputIconStyle()
                        .padding(.leading,8)
                        .foregroundColor(Color.accentColor)
                        .animation(.easeIn(duration: 3), value:leftIcon ?? "")
                } else {
                    Spacer()
                }
                VStack {
                    TextField(placeHoldr, text: $text)
                }
                if rightIcon != nil {
                    Image(systemName:"checkmark.circle.fill")
                        .inputIconStyle()
                        .padding(.trailing,8)
                        .foregroundColor(.green)
                        .animation(.easeIn(duration: 3), value:rightIcon ?? "")
                } else {
                    Spacer()
                }
            }
        }
        .background(
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 55)
                .cornerRadius(4)
        )
        .frame(height: 55)
    }
}

struct AppInputBox_Previews: PreviewProvider {
    @State var emailText: String = "projectedValue"
    static var previews: some View {
        Group {
            AppInputBox(text: "$emailText",
                        leftIcon: "heart.text.square",
                        rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(text: "$emailText",
                        leftIcon: "heart.text.square",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(text: "$emailText",
                        rightIcon: "checkmark.circle.fill",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
            AppInputBox(text: "$emailText",
                        placeHoldr: "Placeholder")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
