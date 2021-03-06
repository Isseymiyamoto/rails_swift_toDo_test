//
//  ToDoService.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

struct ToDoService {
    static var shared = ToDoService()
    
    
    mutating func fetchToDos(completion: @escaping([ToDo])->Void){
        let urlString = "https://rails-api-memo-test.herokuapp.com/memos"
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        var toDos = [ToDo]()
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            switch response.result{
            case .success:
                
                let data = JSON(response.value as Any)
                let tempArray = data.arrayValue
                
                for element in tempArray{
                    let memo = element["text"].stringValue
                    let id = element["id"].int
                    let dictionary = [
                        "memo": memo,
                        "memoID": id as Any
                        ] as [String : Any]
                    let toDo = ToDo(dictionary: dictionary)
                    toDos.append(toDo)
                    completion(toDos)
                }
                
                
            case .failure(let error):
                print("DEBUG: error is \(error)")
            }
        }
    }
    
    
    func uploadToDo(memo: String, completion: @escaping(AFDataResponse<Data>) -> Void){
        // HTTP通信
        let urlString = "https://rails-api-memo-test.herokuapp.com/memos"
        guard let url = URL(string: urlString) else { return }
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters: [String: Any] = [
            "memo": [
                "text": memo
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData(completionHandler: completion)
    }
    
    func deleteToDo(id: Int, completion: @escaping(AFDataResponse<Any>) -> Void){
        let urlString = "https://rails-api-memo-test.herokuapp.com/memos/\(id)"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url, method: .delete, parameters: nil, headers: nil).responseJSON(completionHandler: completion)
    }
}
