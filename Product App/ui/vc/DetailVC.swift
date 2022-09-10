//
//  DetailVC.swift
//  Product App
//
//  Created by MAC on 9.09.2022.
//

import UIKit
import SwiftSoup

class DetailVC: UIViewController {

    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var stockImageView: UIImageView!
    var product : PData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let p = product {
            detailPriceLabel.text = "\(p.price!)$"
            detailTitleLabel.text = p.title
            print(p.description!)
            DispatchQueue.main.async {
                self.detailImageView.setImage(imageUrl: p.featuredImage?.n ?? "")
            }
            if p.campaignPrice != nil {
                discountLabel.textColor = .red
                discountLabel.text = "campaign price: \(p.campaignPrice!)$"
            }else {
                discountLabel.text = ""
            }
            if p.stock == 0 {
                stockImageView.isHidden = false
            }else {
                stockImageView.isHidden = true
            }
            
            do {
                let html = p.description!
               let doc: Document = try SwiftSoup.parse(html)
                descriptionLabel.text = try doc.text()
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
            }
       }
    
    }

    @IBAction func addProductPressed(_ sender: Any) {
        self.showAlert(Title: "Alert", Message: "The product has been added to your shopping cart")
    }
    
}
