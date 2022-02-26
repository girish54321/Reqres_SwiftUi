//
//  AppInputText.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .titleColor(Color.accentColor)
            .selectedLineColor(Color.accentColor)
            .selectedTextColor(.blue)
            .selectedTitleColor(Color.accentColor)
    }
}
