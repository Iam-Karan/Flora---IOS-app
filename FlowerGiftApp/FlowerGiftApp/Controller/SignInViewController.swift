//
//  SignInViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var newUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap()
        // Do any additional setup after loading the view.
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "goToSignUp", sender: self)
     }
     func setupLabelTap(){
         let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
         self.newUser.isUserInteractionEnabled = true
         self.newUser.addGestureRecognizer(labelTap)
     }

    

}
