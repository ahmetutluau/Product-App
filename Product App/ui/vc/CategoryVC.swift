//
//  ViewController.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import UIKit

class CategoryVC: UIViewController {

    var categoryManager = CategoryManager()
    var categoryList = [CData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryManager.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categoryManager.getCategoryList()
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as! Int?
        let destinationVC = segue.destination as! ProductVC
        destinationVC.categoryId = categoryList[index!].categoryId

    }
}
//MARK: - CategoryManagerDelegate
extension CategoryVC: CategoryManagerDelegate {
    func showLoading() {
        self.showspinner()
    }
    
    func hideLoading() {
        self.removeSpinner()
    }
    
    func didUpdateCategory(categoryList: [CData]?) {
        if let clist = categoryList {
            self.categoryList = clist
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}

extension CategoryVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = category.name
        DispatchQueue.main.async {
            cell.categoryImageView.setImage(imageUrl: category.icon!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toProduct", sender: indexPath.row)
    }
    
}

