//
//  AppInputText.swift
//  reqres_swiftui
//
//  Created by Apple on 16/02/22.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

extension FloatingLabelTextField {
    func textModifier() -> some View {
        self
            .titleColor(Color.accentColor)
            .selectedLineColor(Color.accentColor)
            .selectedTextColor(.blue)
            .selectedTitleColor(Color.accentColor)
            .frame(height: 70)
    }
}
