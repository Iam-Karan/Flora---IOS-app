//
//  CartProductCell.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2022-01-17.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol CartProductDelegate : AnyObject {
    func removeItem(product: CartProduct)
}
class CartProductCell: UICollectionViewCell {
    var ref: DatabaseReference!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    var desc = ""
    var productPrice = 0
    var id = 0
    var quantity = 1
    var image = ""
    var productName = ""
    var category = ""
    var isDelete = false
    
    private var item: CartProduct!
    weak var delegate : CartProductDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
    }

    @IBAction func deleteButton(_ sender: Any) {
        delegate?.removeItem(product: item)
//        let userID = Auth.auth().currentUser?.uid
//        let collectionReference = ref?.child("cart").child(userID!).child(String(id))
//        collectionReference!.removeValue { error, _ in
//
//            print(error ?? "went wrong" as Any)
//        }
//        isDelete = true
//        getController()
        
        
    }
   
    func configureCell(product: CartProduct, delegate: CartProductDelegate){
        self.delegate = delegate
        self.item = product
        name.text = product.name
        img.image = UIImage(named: product.img)
        qty.text = "Quantity : " + String(product.qty)
        price.text = "$" + String(product.price)
        id = product.id
    }
//    func getController() -> (Bool){
//        return isDelete
//    }
    func getData(product: CartProduct) -> (String, String, String, Int, String, Int, Int){
        productName = product.name
        image = product.img
        desc = product.desc
        id = product.id
        category = product.category
        quantity = product.qty
        productPrice = product.price
        return (productName,image,desc,id,category,quantity,productPrice)
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
