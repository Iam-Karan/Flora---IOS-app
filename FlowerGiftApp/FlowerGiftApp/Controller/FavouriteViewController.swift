//
//  FavouriteViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var Favourite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        Favourite.isSelected = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func FavouriteButton(_ sender: Any) {
        Favourite.isSelected.toggle()
        // call Button function
        switch Favourite.isSelected {
            case true:
                Favourite.setImage(UIImage(systemName: "heart"), for: .normal)
       
//          print("Button Pressed")
            default:
                Favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//                       print("Button Unpressed")
        }
    }


    
    @IBAction func CartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            guard segue.destination is CartViewController else { return }
        }
    }
    

}
