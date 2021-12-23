//
//  PaymentViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class PaymentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Button(_ sender: Any) {
        var msg = UIAlertController(title: "Success", message: "Order placed successfully", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("OK BUTTON TAPPED")
        })
        msg.addAction(ok)
        self.present(msg, animated: true, completion: nil)
//        performSegue(withIdentifier: "goToHome", sender: self)
//        self.navigationItem.setHidesBackButton(true, animated: true)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToHome"{
//            self.navigationItem.setHidesBackButton(true, animated: true)
////            self.navigationItem.setHidesBackButton(true, animated: true)
//            guard segue.destination is GiftViewController else { return }
//
//        }}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
