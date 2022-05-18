//
//  GlobalState.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 27/02/22.
//

import SwiftUI
import AlertToast

class AlertViewModel: ObservableObject {
    
    @Published var show = false
    @Published var alertToast = AlertToast(type: .regular, title: "SOME TITLE"){
        didSet{
            show.toggle()
        }
    }
}

class AppStateStorage: ObservableObject {
    @Published var selectedUser: UserListResponseData?
}
