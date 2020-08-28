//
//  AuthService.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import Alamofire

struct RegistrationCredentials: Decodable{
    let email: String
    let password: String
}

struct AuthService {
    static let shared = AuthService()
    
    func createUser(credentials: RegistrationCredentials){
        // HTTP通信
        let urlString = ""
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters: [String: Any] = [
            "email": credentials.email,
            "password": credentials.password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let result = response.data {
                print(result)
            }
        }
    }
    
}
