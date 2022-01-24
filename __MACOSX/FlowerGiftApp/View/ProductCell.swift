//
//  ProductCell.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2022-01-14.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
protocol ProductCellDelegate : class{
    func productFavorited(product: Product)
}
class ProductCell: UICollectionViewCell {
    var ref: DatabaseReference!
    @IBOutlet weak var buttonFavourite: UIButton!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var desc = ""
    var price = 0
    var id = 0
    var img = ""
    var name = ""
    var category = ""
//    var userID = ""
    weak var delegate : ProductCellDelegate?
    private var product: Product!
    override func awakeFromNib() {
        super.awakeFromNib()
//        buttonFavourite.isSelected = false
        ref = Database.database().reference()
//        productImage.layer.cornerRadius = 5
       
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
       
        delegate?.productFavorited(product: product)
        
    }
    func configureCell(product: Product, delegate: ProductCellDelegate){
        self.product = product
        self.delegate = delegate
        productLabel.text = product.name
        productImage.image = UIImage(named: product.img)
        print("--------fav----------")
        print(UserService.favourites)
        if UserService.favourites.contains(product){
            buttonFavourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            buttonFavourite.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    func getData(product: Product) -> (String, String, String, Int, Int, Bool, String, Product){
        productLabel.text = product.name
        productImage.image = UIImage(named: product.img)
        desc = product.desc
        id = product.id
        category = product.category
        return (product.name ?? "",product.img,product.desc,product.price, product.id, buttonFavourite.isSelected, product.category, product)
    }

}
