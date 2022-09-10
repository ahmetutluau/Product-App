//
//  ProductData.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import Foundation

struct ProductData: Codable {
    let data : [PData]?
}
struct PData: Codable {
    let title : String?
    let price : Double?
    let campaignPrice : Double?
    let description : String?
    let featuredImage : ImageData?
    let publishmentDate : String?
    let stock : Int?
}
struct ImageData: Codable {
    let t : String?
    let n : String?
}

