//
//  UserListModal.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 13/02/22.
//

import Foundation
struct UserListResponseData : Codable, Identifiable, Equatable {
    let id : Int?
    let email : String?
    var first_name : String?
    let last_name : String?
    let avatar : String?
}

struct UserListResponse : Codable {
    var page : Int?
    var per_page : Int?
    var total : Int?
    var total_pages : Int?
    var data : [UserListResponseData]?
    var support : Support?
}

struct Support : Codable{
    let url : String?
    let text : String?
}
