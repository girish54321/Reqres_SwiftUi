//
//  Userinfo.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

struct Userinfo: View {
    @State private var isAnimation = false
    @EnvironmentObject var appStateStorage: AppStateStorage
    @State private var animationAmout = 1.0
    
    var body: some View {
        VStack (alignment: .center){
            HStack {
                AppNetworkImage(imageUrl: appStateStorage.selectedUser?.avatar ?? "")
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: 120, height: 120)
            }
            //            .offset(x: 0, y: isAnimation ? 0 : -525)
            //            .overlay(
            //                Circle().stroke(.black)
            //                    .scaleEffect(animationAmout)
            //                    .opacity(2 - animationAmout)
            //                    .animation(
            //                        .easeOut(duration: 0.8)
            //                            .repeatForever(autoreverses: false),
            //                        value: animationAmout)
            //            )
            //            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25), value: isAnimation)
            .onAppear{
                print("gogogo")
                isAnimation = true
                animationAmout = 2.0
            }
            VStack(alignment: .center, spacing: 5) {
                Text(appStateStorage.selectedUser?.first_name ?? "Firs Name")
                    .font(.title2)
                    .fontWeight(.heavy)
                Text(appStateStorage.selectedUser?.email  ?? "Last Name")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
//                Button("Button title") {
//                    isAnimation.toggle()
//                }
            } //: VSTACK
            .padding(.vertical,14)
            .opacity(isAnimation ? 1: 0)
            .animation(.easeIn(duration: 0.3), value: isAnimation)
            Spacer()
                .navigationTitle(appStateStorage.selectedUser?.first_name ?? "Title")
        }
    }
    
}

struct Userinfo_Previews: PreviewProvider {
    static var previews: some View {
        Userinfo()
            .environmentObject(AppStateStorage())
    }
}
