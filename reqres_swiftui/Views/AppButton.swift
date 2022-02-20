//
//  AppButton.swift
//  reqres_swiftui
//
//  Created by Apple on 17/02/22.
//

import SwiftUI

struct AppButton: View {
    
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    var whiteButton: Bool?
    var clicked: (() -> Void) /// use closure for callback
    ///
    var body: some View {
//        Button(action: clicked) { /// call the closure here
//            HStack {
//                Text(text) /// your text
//                icon /// your icon image
//            }
//            .foregroundColor(Color.green)
//            .padding()
//            .background(Color(.secondarySystemBackground))
//            .cornerRadius(16)
//        }
        Button(action: clicked) {
            HStack {
                leftIcon ?? leftIcon
                Spacer()
                Text(text).fontWeight(.semibold)
                rightIcon ?? rightIcon
                Spacer()
            }
            .frame(height:25)
            .padding(12)
            .background(whiteButton != nil ? Color.white: Color.accentColor)
            .foregroundColor(  whiteButton != nil ? .black: .white)
//            .border(Color.white, width: 2)
           
            .overlay(
                   RoundedRectangle(cornerRadius: 6)
                       .stroke(Color.blue, lineWidth: 3)
               )
            .cornerRadius(6)
//            .overlay(
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.blue, lineWidth: 4)
//                )

        }
       
    }
    
    struct AppButton_Previews: PreviewProvider {
        static var previews: some View {
            AppButton(text: "Login", rightIcon: Image(systemName: "plus"), clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
            AppButton(text: "Login",rightIcon: Image(systemName: "plus"), whiteButton: true,  clicked: {
                print("Clicked!")
            }).previewLayout(.sizeThatFits).padding()
        }
    }
}
