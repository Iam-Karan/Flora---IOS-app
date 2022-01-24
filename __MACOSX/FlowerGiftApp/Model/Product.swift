//
//  Product.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2022-01-14.
//

import Foundation
import FirebaseDatabase
struct Product{
    var name: String
    var id: Int
    var img: String
    var category: String
    var desc: String
    var price: Int
  
//    init(data: [String: NSDictionary]){
//        self.name = data["productName"] as? String ?? ""
//        self.id = data["productId"] as? String ?? ""
//        self.img = data["image"] as? String ?? ""
////        self.name = data["productName"] as? String ?? ""
//    }
    
}
extension Product : Equatable{
    static func == (lhs: Product, rhs: Product) -> Bool{
        return (lhs.id == rhs.id)
    }
}

