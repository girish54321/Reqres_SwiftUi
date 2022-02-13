//
//  Userinfo.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

struct Userinfo: View {
    var hey : UserListResponseData
    var body: some View {
        VStack (alignment: .center){
            HStack {
                AsyncImage(url: URL(string: hey.avatar!)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .clipShape(
                  RoundedRectangle(cornerRadius: 12)
                )
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
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
