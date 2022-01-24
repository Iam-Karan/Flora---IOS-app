//
//  ViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-08.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController {
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var products = [Product]()
//    var demoArray = [NSDictionary]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
//        let product = Product.init(name: "Rose", id: "olkkk", img: "f4")
//
//        products.append(product)
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.ProductCell)
        fetchProducts()
    }
    
    func fetchProducts(){
        let collectionReference = ref?.child("Products")
        collectionReference?.observe(.childAdded) { (snapshot) in
            let values = snapshot.value as? NSDictionary
            
            let name = values?["productName"] as? String ?? ""
           let id = values?["productId"] as? Int ?? 0
           let img = values?["image"] as? String ?? ""
           let type = values?["category"] as? String ?? ""
           let desc = values?["description"] as? String ?? ""
           let price = values?["price"] as? Int ?? 0
//            print(name)
            let newProduct = Product.init(name: name, id: id, img: img, category: type, desc: desc, price: price)
            self.products.append(newProduct)
            self.collectionView.reloadData()
            
        }

    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.item])
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as! ProductCell
        let name = cell.productLabel.text
        print(indexPath.item)
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 50) / 2
        let cellHeight = cellWidth * 1.5
        print("-----------------------")
        print(cellWidth)
        print(cellHeight)
        print("-----------------------")
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

