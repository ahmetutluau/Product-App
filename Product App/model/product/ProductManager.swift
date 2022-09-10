//
//  ProductManager.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import Foundation

protocol ProductManagerDelegate {
    func didUpdateProduct(productList:[PData]?)
    func didFailWithError(error: Error)
    func showLoading()
    func hideLoading()
}

struct ProductManager {
    
    var delegate : ProductManagerDelegate?
    
    func getProductList(categoryId: String) {
        delegate?.showLoading()
        let urlString = "https://api.shopiroller.com/v2.0/products/advanced-filtered?categoryId=\(categoryId)&sort=Price"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", forHTTPHeaderField: "Api-Key")
            request.setValue("AtS1aPFxlIdVLth6ee2SEETlRxk=", forHTTPHeaderField: "Alias-Key")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil || data == nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let productList = parseJSON(safeData) {
                        delegate?.hideLoading()
                        delegate?.didUpdateProduct(productList: productList)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ productData: Data) -> [PData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductData.self, from: productData)
            return decodedData.data
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
