//
//  UserViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-10.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImg.layer.masksToBounds = true
        userImg.layer.cornerRadius = userImg.bounds.width / 2
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
