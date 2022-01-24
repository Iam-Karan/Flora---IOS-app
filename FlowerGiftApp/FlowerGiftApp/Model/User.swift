//
//  User.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2022-01-18.
//

import Foundation

struct User {
    var id: String
    var email: String
    
    init(id: String = "", email: String = ""){
        self.id = id
        self.email = email
    }
    
    init(data: [String: Any]){
        id = data["id"] as? String ?? ""
        email =  data["email"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any]{
        let data : [String: Any] = [
            "id" : user.id,
            "email": user.email
        ]
        
        return data
    }
}
