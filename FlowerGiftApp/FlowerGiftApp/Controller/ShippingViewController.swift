//
//  ShippingViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class ShippingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BuyButton(_ sender: Any) {
        performSegue(withIdentifier: "goToPayment", sender: self)
    }
    
    

}
