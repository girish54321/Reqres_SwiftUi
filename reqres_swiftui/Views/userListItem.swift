//
//  userListItem.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

struct UserListItem: View {
    var userNmae : String
    var email : String
    var imageUrl : String
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 65, height: 65)
            .clipShape(
              RoundedRectangle(cornerRadius: 12)
            )
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8))
          VStack(alignment: .leading, spacing: 5) {
            Text(userNmae)
              .font(.title2)
              .fontWeight(.heavy)
            Text(email)
              .font(.footnote)
              .multilineTextAlignment(.leading)
              .lineLimit(2)
              .padding(.trailing, 8)
          } //: VSTACK
          .padding(.vertical,16)
        }
    }
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        UserListItem(userNmae: "DEMO", email: "DEMO", imageUrl: "https://reqres.in/img/faces/1-image.jpg")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
