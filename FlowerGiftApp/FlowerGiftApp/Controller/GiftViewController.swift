//
//  GiftViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
class GiftViewController: UIViewController, ProductCellDelegate {
    
    
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
//    @IBOutlet weak var product: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    //
//    @IBOutlet weak var Favourite: UIButton!
//    @IBOutlet weak var hamburgerView: UIView!
//
//    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
//    var isSlideMenuHidden = true
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        ref = Database.database().reference()
//        let product = Product.init(name: "Rose", id: "olkkk", img: "f4")
//
//        products.append(product)
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.ProductCell)
        fetchProducts()
        UserService.getCurrentUser()
//        self.setupLabelTap()
//        Favourite.isSelected = false
//        leadingConstraint.constant = -250
    }
    
//    @IBAction func MenuButton(_ sender: Any) {
//        if isSlideMenuHidden{
//            leadingConstraint.constant = 0
//            UIView.animate(withDuration: 0.3, animations: {
//                self.view.layoutIfNeeded()
//            })
//        }else{
//            leadingConstraint.constant = -250
//            UIView.animate(withDuration: 0.3) {
//                self.view.layoutIfNeeded()
//            }
//        }
//        isSlideMenuHidden = !isSlideMenuHidden
//
//    }
//    @IBAction func FavouriteButton(_ sender: Any) {
//        Favourite.isSelected.toggle()
//        // call Button function
//        switch Favourite.isSelected {
//            case true:
//                Favourite.setImage(UIImage(systemName: "heart"), for: .normal)
//
////          print("Button Pressed")
//            default:
//                Favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
////                       print("Button Unpressed")
//        }
//    }
//    @IBAction func MenuIcon(_ sender: UIBarButtonItem) {
//        if isSlideMenuHidden{
//            sideMenuConstraint.constant = 0
//            UIView.animate(withDuration: 0.3, animations: {
//                view.layoutIfNeeded()})
//        }else{
//            sideMenuConstraint.constant = -250
//            UIView.animate(withDuration: 0.3, animations: {
//                view.layoutIfNeeded()
//            })
//        }
//        isSlideMenuHidden = !isSlideMenuHidden
//    }
//    @objc func imageTapped(_ sender: UITapGestureRecognizer){
//        self.performSegue(withIdentifier: "goToProduct", sender: self)
//        self.navigationItem.backBarButtonItem?.title = ""
//     }
//     func setupLabelTap(){
//         let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
//         self.product.isUserInteractionEnabled = true
//         self.product.addGestureRecognizer(imageTap)
//     }

    @IBAction func CartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: self)
//        self.navigationItem.backBarButtonItem?.title = "Shopping Cart"
    }
    
    @IBAction func HamburgerButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMenu", sender: self)
//        self.navigationItem.backBarButtonItem?.title = "Back"
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
//            print(type)
            
            if(type == "gift"){
                print("-----fetch-------")
                print(name)
                print(id)
                print(desc)
                print(price)
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

extension GiftViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.ProductCell, for: indexPath) as? ProductCell {
            cell.configureCell(product: products[indexPath.item], delegate: self)
            (name,img,desc,price,id,isFavourite,category, product) = cell.getData(product: products[indexPath.item])
//            print("-----------is favouite--------")
//            print(isFavourite)
//            print("------pppppp------")
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
        self.performSegue(withIdentifier: "goToProduct", sender: self)
        
       //        self.navigationItem.backBarButtonItem?.title = ""
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCart"{
            guard segue.destination is CartViewController else { return }
        }
        else if segue.identifier == "goToProduct"{
            if segue.destination is ProductDetailViewController {
            let vc = segue.destination as? ProductDetailViewController
                print("-----gift-------")
                print(name)
                print(id)
                print(desc)
                print(price)
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

