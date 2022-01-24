//
//  FlowerViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
class FlowerViewController: UIViewController, ProductCellDelegate {
  
    

    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var name = ""
    var img = ""
    var id = 0
    var desc = ""
    var price = 0
    var category = ""
    var isFavourite = false
    var products = [Product]()
    var product = Product(name:"",id:1,img:"",category:"",desc:"",price:1)
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.ProductCell)
        fetchProducts()
        UserService.getCurrentUser()
    }
    @IBAction func MenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    
    
    @IBAction func CartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToFCart", sender: self)
    }
   
    func fetchProducts(){
        let collectionReference = ref?.child("Products")
        collectionReference?.observe(.childAdded) { (snapshot) in
            let values = snapshot.value as? NSDictionary
            
            let name = values?["productName"] as? String ?? ""
            let id = values?["productId"] as? Int
            let img = values?["image"] as? String ?? ""
            let type = values?["category"] as? String ?? ""
            let desc = values?["description"] as? String ?? ""
            let price = values?["price"] as? Int ?? 0

            
            if(type == "flower"){
               
                let newProduct = Product.init(name: name, id: id ?? 0, img: img, category: type, desc: desc, price: price)
                self.products.append(newProduct)
            }
            
            self.collectionView.reloadData()
            
        }

    }
    func productFavorited(product: Product) {
        UserService.favoriteSelected(product: product)
        guard let index = products.firstIndex(of: product) else {return}
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
       
    }
}

extension FlowerViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.item], delegate: self)
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as! ProductCell
//        let name = cell.productLabel.text
       (name,img,desc,price,id,isFavourite,category,product) = cell.getData(product: products[indexPath.item])
//        print(indexPath.item)
//        print(name)
//        print(img)
        self.performSegue(withIdentifier: "goToFProduct", sender: self)
        
       //        self.navigationItem.backBarButtonItem?.title = ""
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFCart"{
            guard segue.destination is CartViewController else { return }
        }
        else if segue.identifier == "goToFProduct"{
            if segue.destination is ProductDetailViewController {
            let vc = segue.destination as? ProductDetailViewController
               
                vc?.name = name
                vc?.img = img
                vc?.id = id
                vc?.dec = desc
                vc?.category = category
                vc?.price = price
                vc?.product = product
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = (width - 50) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

