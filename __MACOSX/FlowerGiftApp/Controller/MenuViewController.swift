//
//  MenuViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class MenuViewController: UIViewController {

    @IBOutlet weak var signOut: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userpic: UIImageView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap()
        self.setupImageTap()
        ref = Database.database().reference()
        
       
       
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] snapshot in
              // Get user value
              let value = snapshot.value as? NSDictionary
              let fName = value?["firstName"] as? String ?? ""
              let lName = value?["lastName"] as? String ?? ""
                self.userName.text = fName + " " + lName
            }) { error in
              print(error.localizedDescription)
            }
            self.signOut.text = "Sign Out"
        }
        else{
            self.userName.text = "unknown"
            self.signOut.text = ""
        }
       
        
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            UserService.logoutUser()
            self.performSegue(withIdentifier: "goToMain", sender: self)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
      
       
     }
     func setupLabelTap(){
         let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
         self.signOut.isUserInteractionEnabled = true
         self.signOut.addGestureRecognizer(labelTap)
     }
    @objc func imageTapped(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    func setupImageTap(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
        self.userpic.isUserInteractionEnabled = true
        self.userpic.addGestureRecognizer(imageTap)
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
