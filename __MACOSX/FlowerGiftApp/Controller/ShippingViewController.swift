//
//  ShippingViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class ShippingViewController: UIViewController {
//    var product = CartProduct(name:"",id:1,img:"",category:"",desc:"",price:1,qty:1,subTotal: 0)
    var subtotal = 0.0
    var tax = 0.0
    var cost = 10.0
    var totalPrice = 0.0
    var products = [CartProduct]()
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        subTotalLabel.text = "$" + String(subtotal)
        shippingCostLabel.text = "$" + String(cost)
        tax = subtotal * 0.15
        taxLabel.text = "$" + String(tax)
        totalPrice = tax + cost + subtotal
        totalLabel.text = "$" + String(totalPrice)
    }
    

    @IBAction func BuyButton(_ sender: Any) {
        performSegue(withIdentifier: "goToPayment", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPayment"{
            if segue.destination is PaymentViewController {
            let vc = segue.destination as? PaymentViewController
               
                vc?.products = products
              
               
            }
        }
    }
    

}
