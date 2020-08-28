//
//  ToDo.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import Foundation

struct ToDo {
    let memo: String
    
    init(memo: String){
        self.memo = memo as? String ?? ""
    }
}
