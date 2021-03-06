//
//  UIHelper.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/02/22.
//

import Foundation
import AlertToast
import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .serif))
            .padding(8)
    }
}

extension Text {
    func appTestStyle() -> some View {
        self
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color.accentColor)
    }
}

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
    
    func iconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
    
    func inputIconStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
    }
}

struct AppMessage {
    static let loadindView = AlertToast(type: .loading, title: "Loading")
}

