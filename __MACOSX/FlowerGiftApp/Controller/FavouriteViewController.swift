//
//  FavouriteViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class FavouriteViewController: UIViewController, ProductCellDelegate{
   
    
    func productFavorited(product: Product) {
//        UserService.favoriteSelected(product: product)
        guard let index = products.firstIndex(of: product) else {return}
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.reloadItems(at: [indexPath])
//        collectionView.reloadData()
    }

    
  
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
    @IBOutlet weak var Favourite: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        ref = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.ProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.ProductCell)
        products.removeAll()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.products.removeAll()
            self.fetchFavProducts()
        }
//        UserService.getCurrentUser()
        collectionView.reloadData()
//        fetchFavProducts()
//        UserService.favourites.removeAll()
//        UserService.getCurrentUser()
//        guard let index = UserService.favourites.firstIndex(of: product) else {return}
//        let indexPath = IndexPath(item: index, section: 0)
//        collectionView.reloadItems(at: [indexPath])
//        fetchFavProducts()
        
        
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


    
    @IBAction func MenuButton(_ sender: Any) {
        performSegue(withIdentifier: "goToMenu", sender: self)
    }
    @IBAction func CartButton(_ sender: Any) {
        performSegue(withIdentifier: "goToFavCart", sender: self)
    }
    
    
    func fetchFavProducts(){
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            let collectionReference = ref?.child("favourite").child(userID!)
            collectionReference?.observe(.childAdded) { (snapshot) in
            let values = snapshot.value as? NSDictionary

            let name = values?["productName"] as? String ?? ""
            let id = values?["productId"] as? Int
            let img = values?["productImage"] as? String ?? ""
            let type = values?["category"] as? String ?? ""
            let desc = values?["description"] as? String ?? ""
            let price = values?["price"] as? Int ?? 0
            let newProduct = Product.init(name: name, id: id ?? 0, img: img, category: type, desc: desc, price: price)
            self.products.append(newProduct)
            self.collectionView.reloadData()

        }

    }
       
        
    }
    
}
   


extension FavouriteViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
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
        self.performSegue(withIdentifier: "goToFavProduct", sender: self)

       //        self.navigationItem.backBarButtonItem?.title = ""


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFavCart"{
            guard segue.destination is CartViewController else { return }
        }
        else if segue.identifier == "goToFavProduct"{
            if segue.destination is ProductDetailViewController {
            let vc = segue.destination as? ProductDetailViewController

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
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

