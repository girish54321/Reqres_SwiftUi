//
//  HomeScreen.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//


import SwiftUI
import Alamofire
import AlertToast

struct HomeScreen: View {
    @State var userList: UserListResponse? = nil
    
    @EnvironmentObject var viewModel: AlertViewModel
    @EnvironmentObject var appStateStorage: AppStateStorage
    @State private var showinglogOutAlert = false
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
    @State private var selection: String? = nil
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Userinfo(), tag: "UserInfo", selection: $selection) { EmptyView() }
                List{
                    ForEach(userList?.data ?? []) { item in
                        UserListItem(userNmae: item.first_name!, email: item.email!, imageUrl: item.avatar!)
                            .onTapGesture {
                                appStateStorage.selectedUser = item
                                selection = "UserInfo"
                            }
                    }
                }
                .onAppear(perform: {
                    getUserList()
                })
                .navigationBarTitle("My Friends", displayMode: .automatic)
                .alert(isPresented: $showinglogOutAlert) {
                    Alert(title: Text("Logout?"), message: Text("Are you sure?"),
                          primaryButton: .destructive(Text("Yes")){
                        print("Yes")
                        withAnimation{
                            isLogedIn = false
                        }
                    }, secondaryButton: .cancel(Text("No")){
                        print("No")
                    }
                    )
                }
                .toolbar {
                    Button("Logout") {
                        showinglogOutAlert = true
                    }
                }
                .toast(isPresenting: $viewModel.show){
                    viewModel.alertToast
                }
            }
            .opacity(isAnimating ? 1 : 0)
            .onAppear(perform: {
                withAnimation{
                    isAnimating = true
                }
            })
        }
    }
    
    func getUserList() {
        viewModel.alertToast = AppMessage.loadindView
        let parameters: [String: Any] = [
            "page":"1",
            "per_page":"55"
        ]
        AF.request(AppConst.baseurl+AppConst.usersListUrl,method: .get,parameters: parameters).validate().responseDecodable(of: UserListResponse.self) { (response) in
            if ApiError.checkApiError(response: response.response!){
                guard let responseData = try? JSONDecoder().decode(UserListResponse.self, from: response.data! ) else {
                    print("Error: Couldn't decode data into LoginResponse")
                    return
                }
                userList = responseData
                viewModel.show = false
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().previewDevice("iPhone 13")
            .environmentObject(AlertViewModel())
            .environmentObject(AppStateStorage())
    }
}

