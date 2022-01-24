//
//  CustomizeViewController.swift
//  FlowerGiftApp
//

import UIKit
import FirebaseDatabase

class CustomizeViewController: UIViewController, ProductCellDelegate{
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
            
            if(type == "bouquet"){
                
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

extension CustomizeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.item], delegate: self)
            (name,img,desc,price,id,isFavourite,category, product) = cell.getData(product: products[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as! ProductCell
       (name,img,desc,price,id,isFavourite,category,product) = cell.getData(product: products[indexPath.item])

        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            guard segue.destination is CartViewController else { return }
        }
        else if segue.identifier == "goToDetail"{
            if segue.destination is ProductDetailViewController {
            let vc = segue.destination as? ProductDetailViewController
               
                vc?.product = product
                vc?.name = name
                vc?.img = img
                vc?.id = id
                vc?.dec = desc
                vc?.category = category
                vc?.price = price
            }
        }
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

