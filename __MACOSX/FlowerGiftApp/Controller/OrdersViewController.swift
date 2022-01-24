//
//  OrdersViewController.swift
//  FlowerGiftApp
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class OrdersViewController: UIViewController {
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
    var products = [OrderProduct]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.register(UINib(nibName: Identifiers.OrderProductCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.OrderProductCell)

        products.removeAll()
        fetchOrderProducts()
        collectionView.reloadData()
       
    }
    func fetchOrderProducts(){
        total = 0
        if Auth.auth().currentUser != nil {
            let userID = Auth.auth().currentUser?.uid
            let collectionReference = ref?.child("orders").child(userID!)
            _ = collectionReference?.observe(.value, with: { snapshot in
                for child in snapshot.children {
                    let childSnapshot = snapshot.childSnapshot(forPath: (child as AnyObject).key)
                    print("--------------order------------")
//                    print(childSnapshot)
                    for c in childSnapshot.children{
                        let ss = childSnapshot.childSnapshot(forPath: (c as AnyObject).key)
//                        print(ss.value as Any)
                        let v = ss.value
                        let name = ss.value(forKey: "productName")
                        print(name as Any)
//                        if let dbLocation = ss.value["productName"] as? String {
//                                                print(dbLocation)
//                                            }
                    }
//
                }
            })
//            collectionReference?.observe(.childAdded) { [self] (snapshot) in
//            let values = snapshot.value as? NSDictionary
//            let name = values?["productName"] as? String ?? ""
//            let id = values?["productId"] as? Int
//            let img = values?["productImage"] as? String ?? ""
//            let type = values?["category"] as? String ?? ""
//            let desc = values?["description"] as? String ?? ""
//            let price = values?["price"] as? Int ?? 0
//            let qty = values?["qty"] as? Int ?? 1
//            let subTotal = values?["subtotal"] as? Int ?? 1
            
//                let obj = values!
//                if(obj == nil){
//                    print("x is nil")
//
//                }else{
//                    for (key, value) in values {
//                        let objj = value as! NSDictionary
//                        print(objj["productName"])
//
//
//                    }
//                }
                    
                
//              print(type(of: values))
                
                let newProduct = OrderProduct.init(name: "name", id: 0, orderId: "hjgb",img: "img", category: "type", qty: 9, subTotal: 90, orderDate: "gfg", orderTime: "ghgh")
//                print(newProduct)
            self.products.append(newProduct)

            self.collectionView.reloadData()
//                subTotalLabel.text = "$" + String(total)
        }
           
    }

}

extension OrdersViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.OrderProductCell, for: indexPath) as? OrderProductCell {
            cell.configureCell(product: products[indexPath.item])
            
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
