//
//  reqres_swiftuiApp.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import SwiftUI

@main
struct reqres_swiftuiApp: App {
    
    @AppStorage(AppConst.isLogedIn) var isLogedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLogedIn {
                HomeScreen()
                    .environmentObject(AlertViewModel())
                    .environmentObject(AppStateStorage())
            } else {
                SplashScreen()
                    .environmentObject(AlertViewModel())
                    .environmentObject(AppStateStorage())
            }
        }
    }
}
