//
//  ProductManager.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import Foundation

protocol CategoryManagerDelegate {
    func didUpdateCategory(categoryList:[CData]?)
    func didFailWithError(error: Error)
    func showLoading()
    func hideLoading()
}

struct CategoryManager {
    
    var delegate : CategoryManagerDelegate?
    
    func getCategoryList() {
        delegate?.showLoading()
        let urlString = "https://api.shopiroller.com/v2.0/categories"
        
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
                    if let categoryList = parseJSON(safeData) {
                        delegate?.hideLoading()
                        delegate?.didUpdateCategory(categoryList: categoryList)
                    }
                    
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ categoryData: Data) -> [CData]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CategoryData.self, from: categoryData)
            return decodedData.data
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

