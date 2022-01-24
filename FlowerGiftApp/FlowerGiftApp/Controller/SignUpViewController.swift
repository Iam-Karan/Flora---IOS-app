//
//  SignUpViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var oldUser: UILabel!
    var ref: DatabaseReference!

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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

    func validateFields() -> String? {
        if fName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
//        let cleanedPassword = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//       if utilities.isPasswordValid(cleanedPassword) == false {
//        return "Please make sure your password is 8 characters long, contains special characters and a number"
//    }
        return nil
    }
    
    @IBAction func signUpButton(_ sender: Any) {
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
            let fNameField = fName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lNameField = lName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailField = email.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneField = phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordField = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: emailField!, password: passwordField!) { [self] (result, err) in
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
                   
                    self.ref.child("users").child(result!.user.uid).setValue(["firstName": fNameField,"lastName": lNameField,"phoneNumber": phoneField,"email": emailField, "password" : passwordField])
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    
                }
            }
        }
        
    }
    
}
