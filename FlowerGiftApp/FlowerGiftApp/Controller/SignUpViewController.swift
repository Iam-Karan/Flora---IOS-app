//
//  SignUpViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var oldUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap()
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "goToSignIn", sender: self)
     }
     func setupLabelTap(){
         let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
         self.oldUser.isUserInteractionEnabled = true
         self.oldUser.addGestureRecognizer(labelTap)
     }

    

}
