//
//  PaymentViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class PaymentViewController: UIViewController {
    var ref: DatabaseReference!
    var products = [CartProduct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print("---------IN PAYEMENT---------")
        print(products)
        
    
        
        
        
        
    }
    func generateVersionOneAkaTimeBasedUUID() -> String? {
        // figure out the sizes
        let uuidSize = MemoryLayout<uuid_t>.size
        let uuidStringSize = MemoryLayout<uuid_string_t>.size
        // get some ram
        let uuidPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: uuidSize)
        let uuidStringPointer = UnsafeMutablePointer<Int8>.allocate(capacity: uuidStringSize)
        // do the work in C
        uuid_generate_time(uuidPointer)
        uuid_unparse(uuidPointer, uuidStringPointer)
        // make a Swift string while we still have the C stuff
        let uuidString = NSString(utf8String: uuidStringPointer) as String?
        // avoid leaks
        uuidPointer.deallocate()
        uuidStringPointer.deallocate()
        assert(uuidString != nil, "uuid (V1 style) failed")
        return uuidString
    }
    func removeItem(product: CartProduct) {

        if Auth.auth().currentUser != nil {
        let userID = Auth.auth().currentUser?.uid
        let collectionReference = ref?.child("cart").child(userID!).child(String(product.id))
              collectionReference!.removeValue { error, _ in

                  print(error ?? "went wrong" as Any)
              }}
    }
    @IBAction func Button(_ sender: Any) {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let uid = generateVersionOneAkaTimeBasedUUID()
      
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            for product in products {
                ref.child("orders").child(userID!).child(uid!).child(String(product.id)).setValue(["productId": product.id,"productName": product.name, "productImage": product.img, "category": product.category,"qty": product.qty, "subtotal": product.subTotal, "orderdOn" : ServerValue.timestamp(), "orderTime" :(String(hour) + ":" + String(minutes)), "orderId": uid])
                removeItem(product: product)
            }


        }
        var msg = UIAlertController(title: "Success", message: "Order placed successfully", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "goToHome", sender: self)
        })
        msg.addAction(ok)
        self.present(msg, animated: true, completion: nil)
        
//        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
