//
//  ProductDetailViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ProductDetailViewController: UIViewController {
    var ref: DatabaseReference!
    
   
    @IBOutlet weak var labelQty: UILabel!
    
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var productDec: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var Favourite: UIButton!
    var product = Product(name:"",id:1,img:"",category:"",desc:"",price:1)
    var name = ""
    var img = ""
    var dec = ""
    var price : Int = 0
    var id : Int = 0
    var category = ""
    var count = 1
//    var favDictionary: KeyValuePairs = ["productId":0]
    var pairs = KeyValuePairs<String, Int>()
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let post : [String: Int] = ["storedName" : 0 , "storedName" : 1 ]
//        print(post)
//        print(name)
//        print(img)
//        let a: KeyValuePairs = [
//            "a": 0,
//            "a": 1,
//        ]

//        print(a)
        pairs = ["productId":0,]
        pairs = ["productId":3,]
        print("-----pairs-------")
        print(pairs)
        print("--------------------------")
        print(id)
        print(name)
        print(dec)
        print(price)
        print("--------------------------")
        productName.text = name
        productImage.image = UIImage(named: img)
        productPrice.text = "$"+String(price)
        productDec.text = dec
        ref = Database.database().reference()
       
        count = 1
        labelQty.text = String(count)
        Favourite.isSelected = false
        if UserService.favourites.contains(product){
            Favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            Favourite.isSelected = true
        }
        else{
            Favourite.setImage(UIImage(systemName: "heart"), for: .normal)
            Favourite.isSelected = false
        }
        print("---------------selected-----------")
        print(Favourite.isSelected)
    }
    
    @IBAction func FavouriteButton(_ sender: Any) {
        Favourite.isSelected.toggle()
//         call Button function
        if(Favourite.isSelected == true){
            Favourite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else{
            Favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if Auth.auth().currentUser != nil {
                let userID = Auth.auth().currentUser?.uid
//                    favArray.append("productId": id)
                ref.child("favourite").child(userID!).child(String(id)).setValue(["productId": id,"productName": name, "productImage": img, "description": dec, "price": price, "category": category])

            }
        }
//        switch Favourite.isSelected {
//            case true:
//                Favourite.setImage(UIImage(systemName: "heart"), for: .normal)
//
////          print("Button Pressed")
//            default:
//                Favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                if Auth.auth().currentUser != nil {
//                    let userID = Auth.auth().currentUser?.uid
////                    favArray.append("productId": id)
//                    ref.child("favourite").child(userID!).child(String(id)).setValue(["productId": id,"productName": name, "productImage": img, "description": dec, "price": price, "category": category])
//
//                }
////                       print("Button Unpressed")
//        }
        
    }
    
    @IBAction func CartButton(_ sender: Any) {
        showToast(controller: self, message: "added to add to cart", seconds: 1)
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            ref.child("cart").child(userID!).child(String(id)).setValue(["productId": id,"productName": name, "productImage": img, "description": dec, "price": price, "category": category,"qty": count, "subtotal": count * price])
       
        }
//        performSegue(withIdentifier: "goToCart", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            guard segue.destination is CartViewController else { return }
        }
    }
    
    
    
    @IBAction func minusButton(_ sender: Any) {
        if(count <= 1){
            count = 1
            labelQty.text = String(count)
        }
        else{
            count -= 1
            labelQty.text = String(count)
        }
    }
    
    @IBAction func plusButton(_ sender: Any) {
        if(count >= 20){
            count = 20
            labelQty.text = String(count)
        }
        else{
            count += 1
            labelQty.text = String(count)
        }
    }
    
    func showToast(controller: UIViewController, message: String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
    }
}
