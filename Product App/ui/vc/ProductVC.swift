//
//  ProductVC.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import UIKit

class ProductVC: UIViewController {

    var productManager = ProductManager()
    var productList = [PData]()
    
    @IBOutlet weak var barItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var categoryId : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        productManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        setup()
        
    }
    func setup() {
        if let cId = self.categoryId {
            self.productManager.getProductList(categoryId: cId)
        }
        
        let usersItem = UIAction(title: "Price") { (action) in
            self.productList.sort { $0.price! < $1.price! }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let addUserItem = UIAction(title: "Title") { (action) in
            self.productList.sort { $0.title! < $1.title! }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let removeUserItem = UIAction(title: "PublishmentDate") { (action) in
            self.productList.sort { $0.publishmentDate! < $1.publishmentDate! }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let menu = UIMenu(title: "Sort By", options: .displayInline, children: [removeUserItem,  addUserItem , usersItem])
        
        barItem.menu = menu
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as! Int?
        let destinationVC = segue.destination as! DetailVC
        destinationVC.product = productList[index!]
    }
    
}

//MARK: - ProductManagerDelegate
extension ProductVC: ProductManagerDelegate {
    func showLoading() {
        self.showspinner()
    }
    
    func hideLoading() {
        self.removeSpinner()
    }
    
    
    func didUpdateProduct(productList: [PData]?) {
        if let plist = productList {
            self.productList = plist
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}
extension ProductVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let title = product.title {
            cell.titleLabel.text = title
        }
        if let price = product.price {
            cell.priceLabel.text = "\(price)$"
        }
        if product.campaignPrice != nil {
            cell.discountPriceLabel.textColor = .red
            cell.discountPriceLabel.text = "campaign price: \(product.campaignPrice!)$"
        }else {
            cell.discountPriceLabel.text = ""
        }
        DispatchQueue.main.async {
            cell.productImageView.setImage(imageUrl: product.featuredImage?.t ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}
