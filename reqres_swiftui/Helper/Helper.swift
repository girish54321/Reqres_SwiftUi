//
//  Helper.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 24/04/22.
//

import Foundation

struct Helpers {
    static func isVaildEmailRegx(text:String) -> Bool {
        var isValidEmail = false
        let result = text.range(
            of: AppConst.emailPattern,
            options: .regularExpression
        )
        isValidEmail = (result != nil)
        return isValidEmail
    }
    
    static func isValidPassword(text:String) -> Bool {
        var isValidPassword = false
     
        if text.count >= 6 {
            isValidPassword = true
        } else {
            isValidPassword = false
        }
        return isValidPassword
    }
}
