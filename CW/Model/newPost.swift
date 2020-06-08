//
//  newPost.swift
//  CW
//
//  Created by Егор on 05.06.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String : Any])
}

struct Post {
    var name: String
    var district: String
    var content: String
    var payment: String
    var timeStamp: Date
    
    var dictionary:[String : Any] {
    
        return [
            "name":name,
            "district":district,
            "content":content,
            "payment":payment,
            //"timeStamp": timeStamp
        ]
    }
    
}

extension Post : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
        let district = dictionary["district"] as? String,
        let content = dictionary["content"] as? String,
        let payment = dictionary["payment"] as? String,
        let timeStamp = dictionary["timeStamp"] as? Timestamp  else {return nil}
        
        let tsdate = timeStamp.dateValue()
        
        self.init(name : name, district : district, content : content, payment : payment, timeStamp : tsdate)
    }
}
