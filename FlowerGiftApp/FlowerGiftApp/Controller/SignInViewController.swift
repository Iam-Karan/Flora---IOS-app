//
//  SignInViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit
import FirebaseAuth
class SignInViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var newUser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLabelTap()
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "goToSignUp", sender: self)
     }
     func setupLabelTap(){
         let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
         self.newUser.isUserInteractionEnabled = true
         self.newUser.addGestureRecognizer(labelTap)
     }
    func validateFields() -> String? {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        return nil
   }
       
    @IBAction func signinButton(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            let msg = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("OK BUTTON TAPPED")
            })
            msg.addAction(ok)
            self.present(msg, animated: true, completion: nil)
        }
        else{
            let emailField = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordField = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().signIn(withEmail: emailField!, password: passwordField!) { (result, err) in
                if err != nil{
//                    err?.localizedDescription
                    let msg = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("OK BUTTON TAPPED")
                    })
                    msg.addAction(ok)
                    self.present(msg, animated: true, completion: nil)
                }
                else{
                   
                   self.performSegue(withIdentifier: "goToHome", sender: self)
                    
                }
            }
    
        }
        
        }
       

}
