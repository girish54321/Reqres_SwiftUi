//
//  SplashScreen.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 20/02/22.
//

import SwiftUI


struct SplashScreen: View {
    
    @State private var selection: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg1")
                    .resizable()
                    .ignoresSafeArea()
                VStack(alignment: .center,spacing: 19)  {
                    NavigationLink(destination: LoginScreen(), tag: "A", selection: $selection) { EmptyView() }
                    NavigationLink(destination: CreateAccountScreen(), tag: "B", selection: $selection) { EmptyView() }
                    VStack(alignment: .leading,spacing: 10) {
                        Text("ReqRes App")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.white)
                        Text( "Hold the tinsel—the rainbow eucalyptus tree doesn’t need decorations to appear festive for the holidays.")
                            .foregroundColor(Color.white)
                            .font(.footnote)
                    } // VSTACK
                    .padding(.horizontal)
                    
                    Capsule()
                        .frame(height: 2)
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.horizontal)
                    VStack (alignment: .center,spacing: 16) {
                        AppButton(text: "Login Up",
                                  whiteButton: true,
                                  clicked: {
                            selection = "A"
                           
                        })
                        AppButton(text: "Sign Up",
                                  clicked: {
                            selection = "B"
                        })
                    }
                    .padding(.horizontal)
                } // VSTACK
                .offset(x: 0, y: 190)
            }
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen().previewDevice("iPhone 13")
    }
}
