//
//  UserServices.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2022-01-18.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

let UserService = _UserService()

final class _UserService {
    var user =  User()
    var favourites = [Product]()
    let auth = Auth.auth()
    let db = Database.database().reference()
    var userListener : ListenerRegistration? = nil
    var favsListener : ListenerRegistration? = nil
    
    var isGuest :  Bool{
        guard let authUser = auth.currentUser else {
            return true
        }
        if authUser.isAnonymous {
            return true
        }else{
            return false
        }
    }
    
    func getCurrentUser(){
        guard let authUser = auth.currentUser else {return}
        let userRef = db.child("users").child(authUser.uid)
        userRef.observe(.childAdded) { (snap, err) in
            if let err = err {
                print(err)
                return
            }
            guard let data = snap.value else {return}
//            self.user = User.init(data: data as! [String : Any])
        }
        
        let userID = Auth.auth().currentUser?.uid
        let collectionReference = db.child("favourite").child(userID!)
        collectionReference.observe(.childAdded) { (snapshot) in
        let values = snapshot.value as? NSDictionary
        
        let name = values?["productName"] as? String ?? ""
        let id = values?["productId"] as? Int
        let img = values?["productImage"] as? String ?? ""
        let type = values?["category"] as? String ?? ""
        let desc = values?["description"] as? String ?? ""
        let price = values?["price"] as? Int ?? 0
        let newProduct = Product.init(name: name, id: id ?? 0, img: img, category: type, desc: desc, price: price)
        self.favourites.append(newProduct)
        }
    }
    
    func favoriteSelected(product: Product){
        let userID = Auth.auth().currentUser?.uid
        let favsRef = db.child("favourite").child(userID!).child(String(product.id))
//        let collectionReference = ref?.child("cart").child(userID!).child(String(id))
        //        collectionReference!.removeValue { error, _ in
        //
        //            print(error ?? "went wrong" as Any)
        //        }
        if favourites.contains(product){
            favourites.removeAll{ $0 == product}
            favsRef.removeValue { error, _ in
            
                        print(error ?? "went wrong" as Any)
            }
            
        }else{
            favourites.append(product)
            favsRef.setValue(["productId": product.id,"productName": product.name, "productImage": product.img, "description": product.desc, "price": product.price, "category": product.category])
        }
    }
    func logoutUser(){
        userListener?.remove()
        userListener = nil
//        favsListener?.remove()
//        favsListener = nil
        user = User()
        favourites.removeAll()
    }
}
