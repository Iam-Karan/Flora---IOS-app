//
//  CartViewController.swift
//  FlowerGiftApp
//
//  Created by Priya Gondaliya on 2021-12-09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CartViewController: UIViewController, CartProductDelegate {
    
    
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var name = ""
    var img = ""
    var id = 0
    var desc = ""
    var price = 0
    var category = ""
    var qty = 1
    var subTotal = 1
    var total = 0
    var products = [CartProduct]()
    var product = CartProduct(name:"",id:1,img:"",category:"",desc:"",price:1,qty:1,subTotal: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setHidesBackButton(true, animated: true)
        ref = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.CartProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CartProductCell)
//        products.removeAll()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.products.removeAll()
            self.fetchCartProducts()
        }
        collectionView.reloadData()
        total = 0
//        fetchCartProducts()
//        print("---------------------vvvvvvvv-----------")
//        print(products)
//        for p in products {
//
//            print(p)
//        }
//        subTotalLabel.text = String(total)
        
       
    }
    
    @IBAction func BuyButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToShipping", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShipping"{
            if segue.destination is ShippingViewController {
            let vc = segue.destination as? ShippingViewController
               
                vc?.products = products
                vc?.subtotal = Double(total)
               
            }
        }
    }
    func removeItem(product: CartProduct) {

        if Auth.auth().currentUser != nil {
        let userID = Auth.auth().currentUser?.uid
        let collectionReference = ref?.child("cart").child(userID!).child(String(product.id))
              collectionReference!.removeValue { error, _ in

                  print(error ?? "went wrong" as Any)
              }}
    }
    
    func fetchCartProducts(){
        total = 0
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            let collectionReference = ref?.child("cart").child(userID!)
            collectionReference?.observe(.childAdded) { [self] (snapshot) in
            let values = snapshot.value as? NSDictionary
//                print("------------------cart value---")
//            print(values)
            let name = values?["productName"] as? String ?? ""
            let id = values?["productId"] as? Int
            let img = values?["productImage"] as? String ?? ""
            let type = values?["category"] as? String ?? ""
            let desc = values?["description"] as? String ?? ""
            let price = values?["price"] as? Int ?? 0
            let qty = values?["qty"] as? Int ?? 1
            let subTotal = values?["subtotal"] as? Int ?? 1
            total = total + subTotal
//                print("-----to-------")
//                print(total)
                
                let newProduct = CartProduct.init(name: name, id: id ?? 0, img: img, category: type, desc: desc, price: price, qty: qty, subTotal: subTotal)
                print(newProduct)
            self.products.append(newProduct)
               
            self.collectionView.reloadData()
                subTotalLabel.text = "$" + String(total)
        }
           
    }
 }
    
}

extension CartViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CartProductCell, for: indexPath) as? CartProductCell {
            cell.configureCell(product: products[indexPath.item], delegate: self)
            
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellWidth = width
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
