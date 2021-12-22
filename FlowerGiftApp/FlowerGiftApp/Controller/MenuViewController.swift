//
//  MenuViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = profilePicture.bounds.width / 2
        self.profilePicture.clipsToBounds = true
        self.setupImageTap()
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "goToSignIn", sender: self)
     }
     func setupImageTap(){
         let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
         self.profilePicture.isUserInteractionEnabled = true
         self.profilePicture.addGestureRecognizer(imageTap)
     }
    @IBAction func giftFinderButton(_ sender: Any) {
        performSegue(withIdentifier: "goToGiftFinder", sender: self)
    }
    @IBAction func orderButton(_ sender: Any) {
        performSegue(withIdentifier: "goToOrders", sender: self)
    }
    @IBAction func userButton(_ sender: Any) {
        performSegue(withIdentifier: "goToUser", sender: self)
    }
}
