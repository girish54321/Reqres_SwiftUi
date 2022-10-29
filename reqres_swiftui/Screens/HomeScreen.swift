//
//  HomeScreen.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//


import SwiftUI
import Alamofire
import FloatingLabelTextFieldSwiftUI
import AlertToast

struct HomeScreen: View {
    @State var userList: UserListResponse? = nil
    @State var responseData: UserListResponse? = nil
    
    @EnvironmentObject var viewModel: AlertViewModel
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    @State private var showinglogOutAlert = false
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
    @State private var selection: String? = nil
    @State private var searchText = ""
    @State private var isAnimating: Bool = false
    @State var didAppear = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Userinfo(), tag: "UserInfo", selection: $selection) { EmptyView() }
                List {
                    ForEach(userList?.data ?? []) { item in
                        UserListItem(userNmae: item.first_name!, email: item.email!, imageUrl: item.avatar!)
                            .onTapGesture {
                                appStateStorage.selectedUser = item
                                selection = "UserInfo"
                            }
                            .onAppear {
                                if item == userList?.data?.last {
                                    print("On onAppear")
                                    loadMoreUsers()
                                }
                            }
                    }
                }
                .onAppear(perform: {
                    if !didAppear {
                        getUserList()
                    }
                    didAppear = true
                })
                .navigationBarTitle("My Friends", displayMode: .automatic)
                .alert(isPresented: $showinglogOutAlert) {
                    Alert(title: Text("Logout?"),
                          message: Text("Are you sure?"),
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
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: {newValue in
                if(newValue.count < 0 || searchText == ""){
                    withAnimation {
                        userList?.data = responseData?.data
                    }
                    return
                }
                let newArray = responseData?.data?.filter({ return $0.first_name?.contains(newValue) as! Bool })
                
                withAnimation{
                    userList?.data = newArray
                }
            })
            .onAppear(perform: {
                if !didAppear {
                    viewModel.alertToast = AlertToast(
                        displayMode: .banner(.slide),
                        type: .error(.red),
                        title: "Email & Password are required",
                        subTitle: "please check error")
                }
                
                withAnimation{
                    isAnimating = true
                }
            })
        }
    }
    
    func loadMoreUsers(){
        if(responseData != nil && responseData?.page ?? 0 <= responseData?.total_pages ?? 1){
            getUserList()
        }
    }
    
    func getUserList() {
        print("Dping API call")
        viewModel.alertToast = AppMessage.loadindView
        let parameters: [String: Any] = [
            "page":"1",
            "per_page":"55"
        ]
        UserServices().getUserList(parameters: parameters){
            result in
            viewModel.show = false
            switch result {
            case .success(let data):
                if(self.userList == nil){
                    self.userList = data
                    self.responseData = data
                } else {
                    self.userList?.data?.append(contentsOf: data.data!)
                    self.userList?.page = data.page! + 1
                    self.userList?.total_pages = data.total_pages
                    
                    self.responseData?.data?.append(contentsOf: data.data!)
                    self.responseData?.page = data.page! + 1
                    self.responseData?.total_pages = data.total_pages
                }
            case .failure(let error):
                switch error {
                case .NetworkErrorAPIError(let errorMessage):
                    print(errorMessage)
                case .BadURL:
                    print("BadURL")
                case .NoData:
                    print("NoData")
                case .DecodingErrpr:
                    print("DecodingErrpr")
                }
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

