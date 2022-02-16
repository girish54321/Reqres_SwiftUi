//
//  Userinfo.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

extension Image {
  func imageModifier() -> some View {
    self
      .resizable()
      .scaledToFit()
      .clipShape(Circle())
  }
  
  func iconModifier() -> some View {
    self
      .imageModifier()
      .frame(maxWidth: 128)
      .foregroundColor(.purple)
      .opacity(0.5)
  }
}

struct Userinfo: View {
    var hey : UserListResponseData
    @State private var isAnimation = false
    
    @State private var animationAmout = 1.0
    var body: some View {
        VStack (alignment: .center){
            HStack {
                AppNetworkImage(imageUrl: hey.avatar!)
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .frame(width: 120, height: 120)
            }
//            .offset(x: 0, y: isAnimation ? 0 : -525)
            .overlay(
                Circle().stroke(.black)
                    .scaleEffect(animationAmout)
                    .opacity(2 - animationAmout)
                    .animation(
                        .easeOut(duration: 0.8)
                            .repeatForever(autoreverses: false),
                        value: animationAmout)
            )
//            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25), value: isAnimation)
            .onAppear{
                print("gogogo")
                isAnimation = true
                animationAmout = 2.0
            }
//            HStack {
//                Image(systemName: "ant.circle.fill").iconModifier()
//            .frame(width: 120, height: 120)
//            }
//            .offset(x: 0, y: isAnimation ? 0 : -525)
//            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25), value: isAnimation)
          VStack(alignment: .center, spacing: 5) {
              Text(hey.first_name!)
              .font(.title2)
              .fontWeight(.heavy)
              Text(hey.email!)
              .font(.footnote)
              .multilineTextAlignment(.leading)
              .lineLimit(2)
              .padding(.trailing, 8)
              Button("Button title") {
                  isAnimation.toggle()
              }
          } //: VSTACK
          .padding(.vertical,14)
          .opacity(isAnimation ? 1: 0)
          .animation(.easeIn(duration: 0.3), value: isAnimation)
            Spacer()
        .navigationTitle(hey.first_name!)
        }
    }
    
}

struct Userinfo_Previews: PreviewProvider {
    static var previews: some View {
        let demmydata: UserListResponse = Bundle.main.decode("userlist.json")
        Userinfo(hey: demmydata.data![0])
    }
}
