//
//  UIHelper.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/02/22.
//

import Foundation
//
//  UIHelper.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/02/22.
//
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


//struct InputTextIconModifier: ViewModifier {
//  func body(content: Content) -> some View {
//    content
//          .resizable()
//          .scaledToFit()
//          .frame(width: 24, height: 24)
//  }
//}

extension Image {
    func imageModifier() -> some View {
    self
      .resizable()
      .scaledToFit()
      .clipShape(Circle())
  }
  
  func iconModifier() -> some View {
    self
//      .imageModifier()
//      .frame(maxWidth: 128)
//      .foregroundColor(.purple)
//      .opacity(0.5)
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
  }
    
    func inputIconStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
}
