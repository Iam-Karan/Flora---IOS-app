//
//  ProductDetailViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var Favourite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Favourite.isSelected = false
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
