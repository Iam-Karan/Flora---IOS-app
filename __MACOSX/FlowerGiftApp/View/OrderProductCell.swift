//
//  OrderProductCell.swift
//  FlowerGiftApp
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class OrderProductCell: UICollectionViewCell {
    var ref: DatabaseReference!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ref = Database.database().reference()
    }
    func configureCell(product: OrderProduct){
        
        name.text = product.name
        image.image = UIImage(named: product.img)
        qty.text = "Quantity : " + String(product.qty)
        total.text = "Total : " + String(product.subTotal)
        time.text = "Orderd on : " + String(product.orderDate) + " " + String(product.orderTime)
    }
}
