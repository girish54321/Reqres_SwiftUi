//
//  HomeScreen.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

struct HomeScreen: View {
    let data: UserListResponse = Bundle.main.decode("userlist.json")
    var body: some View {
        NavigationView {
            List{
                ForEach(data.data!) { item in
                    NavigationLink(destination: Userinfo(hey: item)) {
                        UserListItem(userNmae: item.first_name!, email: item.email!, imageUrl: item.avatar!)
                    } //: LINK
                }
                
            }
            .navigationBarTitle("Home", displayMode: .automatic)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().previewDevice("iPhone 13")
    }
}
