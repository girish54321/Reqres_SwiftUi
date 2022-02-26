//
//  AuthModal.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/02/22.
//

import Foundation
struct LoginResponse : Decodable {
    var token: String?
}
struct LoginResponseError : Decodable {
    var error: String?
}

struct RegisterResponse : Codable {
    let id : Int?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}
