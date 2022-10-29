//
//  UserService.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 25/10/22.
//

import Foundation
import Alamofire

class UserServices {
    
    func getUserList (
        parameters: Parameters?,
        completion: @escaping(Result<UserListResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: UserListResponse.self,
                                         endPoint: UserDataApiEndPoint().createEndPoint(endPoint: .userList),
                                         method:.get,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
}
