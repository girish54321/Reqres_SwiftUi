//
//  AuthModal.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/02/22.
//

import Foundation
struct LoginScuccess: Codable {
    let token: String?
}

struct LoginFail: Codable {
    let error: String?
}

// MARK: - CreateAccoutResponse
struct CreateAccoutResponse: Codable {
    let id: Int?
    let token: String?
}
