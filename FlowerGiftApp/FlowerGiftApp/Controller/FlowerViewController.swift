//
//  FlowerViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit

class FlowerViewController: UIViewController {

    @IBOutlet weak var Favourite: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    override func viewDidLoad() {
        super.viewDidLoad()
        Favourite.isSelected = false
        leadingConstraint.constant = -250
    }
    @IBAction func MenuButton(_ sender: Any) {
        if isSlideMenuHidden{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            leadingConstraint.constant = -250
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        isSlideMenuHidden = !isSlideMenuHidden
        
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
