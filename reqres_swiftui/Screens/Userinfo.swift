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
    @State private var isAnimation = false;
    var body: some View {
        VStack (alignment: .center){
            HStack {
                AsyncImage(url: URL(string: hey.avatar!), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                  switch phase {
                  case .success(let image):
                    image
                      .imageModifier()
                      // .transition(.move(edge: .bottom))
                      // .transition(.slide)
                      .transition(.scale)
                  case .failure(_):
                    Image(systemName: "ant.circle.fill").iconModifier()
                  case .empty:
                    Image(systemName: "photo.circle.fill").iconModifier()
                  @unknown default:
                    ProgressView()
                  }
                }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .frame(width: 120, height: 120)
            }
            .onAppear{
                print("gogogo")
                isAnimation.toggle()
            }
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
