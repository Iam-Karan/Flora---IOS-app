//
//  CartViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BuyButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToShipping", sender: self)
    }
    
    
}
