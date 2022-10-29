//
//  AuthServices.swift
//  reqres_swiftui
//
//  Created by Girish Parate on 26/10/22.
//

import Foundation
import Alamofire

class AuthServices {
    
    func userLogin (
        parameters: Parameters?,
        completion: @escaping(Result<LoginScuccess,NetworkError>) -> Void){
            return RestAPIClient.request(type: LoginScuccess.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .login),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
    
    func createAccount (
        parameters: Parameters?,
        completion: @escaping(Result<CreateAccoutResponse,NetworkError>) -> Void){
            return RestAPIClient.request(type: CreateAccoutResponse.self,
                                         endPoint: AuthApiEndpoint().createEndPoint(endPoint: .register),
                                         method:.post,
                                         parameters:parameters,
                                         completion: completion
            )
        }
}
