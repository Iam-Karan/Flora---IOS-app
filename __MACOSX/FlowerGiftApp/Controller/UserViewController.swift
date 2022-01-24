//
//  UserViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class UserViewController: UIViewController {

    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var update: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        userImg.layer.masksToBounds = true
        userImg.layer.cornerRadius = userImg.bounds.width / 2
        
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] snapshot in
              // Get user value
              let value = snapshot.value as? NSDictionary
              let fName = value?["firstName"] as? String ?? ""
              let lname = value?["lastName"] as? String ?? ""
              let usremail = value?["email"] as? String ?? ""
              let userpassword = value?["password"] as? String ?? ""
              let phoneNumber = value?["phoneNumber"] as? String ?? ""
                name.text = fName
                lName.text = lname
                email.text = usremail
                password.text = userpassword
                phone.text = phoneNumber
                
              
            }) { error in
              print(error.localizedDescription)
            }
           
        }
       
    }
    func validateFields() -> String? {
        if name.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phone.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
//        let cleanedPassword = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//       if utilities.isPasswordValid(cleanedPassword) == false {
//        return "Please make sure your password is 8 characters long, contains special characters and a number"
//    }
        return nil
    }

    @IBAction func updateButton(_ sender: Any) {
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
            let nameField = name.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lnameField = lName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailField = (email.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            let phoneField = phone.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordField = password.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let userID = Auth.auth().currentUser?.uid
            let authEmail = Auth.auth().currentUser?.email
            
            let user = Auth.auth().currentUser
            if(authEmail != email.text){
                user?.updateEmail(to:  (email.text)!) { (error) in
                    print(error)
                                   
                }
            
            }
            user?.updatePassword(to: (password.text)!) { error in
              print(error)
            }
            self.ref.child("users").child(userID!).setValue(["firstName": nameField,"lastName": lnameField,"phoneNumber": phoneField,"email": emailField, "password" : passwordField])
            let msg = UIAlertController(title: "success", message: "Profile Updated", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("OK BUTTON TAPPED")
            })
            msg.addAction(ok)
            self.present(msg, animated: true, completion: nil)
        }
        
    }
    }
    


