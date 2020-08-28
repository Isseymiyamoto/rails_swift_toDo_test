//
//  AuthService.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

struct AuthCredentials: Decodable{
    let email: String
    let password: String
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail: String, password: String){
        let urlString = "https://rails-api-memo-test.herokuapp.com/users"
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "authorization"
        ]
    }
    
    func createUser(credentials: AuthCredentials, completion: @escaping(AFDataResponse<Data>) -> Void){
        // HTTP通信
        let urlString = "https://rails-api-memo-test.herokuapp.com/users"
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters: [String: Any] = [
            "user": [
                "email": credentials.email,
                "password": credentials.password
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: completion)
    }
    
//    func createUser(credentials: RegistrationCredentials){
//        // HTTP通信
//        let urlString = "https://rails-api-memo-test.herokuapp.com/users"
//        guard let url = URL(string: urlString) else { return }
//        let headers: HTTPHeaders = [
//            "Contenttype": "application/json"
//        ]
//        let parameters: [String: Any] = [
//            "user": [
//                "email": credentials.email,
//                "password": credentials.password
//            ]
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: { (response) in
//            switch response.result{
//            case .success(_):
//                if let data = response.data{
//                    print(data)
//                }
//
//            case .failure(let error):
//                print("Error is \(error)")
//            }
//        })
//    }
    
    func fetchUser(){
        
        let urlString = "https://rails-api-memo-test.herokuapp.com/memos"
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
        }
        
    }
    
}
