//
//  CategoryData.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import Foundation

struct CategoryData: Codable {
    let data : [CData]?
}

struct CData: Codable {
    let categoryId : String?
    let name : String?
    let icon : String?
}

/*
 "categoryId": "61b1f109a82ec0dd1c56f5ed",
             "name": "Economic Menu",
             "icon": "https://content.cdn.shopiroller.com/96c2a43e-f957-46d5-83e2-bf9daa077464/images/1015b907-f6ae-4fe3-892a-6ea46dadaecf.png",
             "orderIndex": 1,
             "createDate": "2021-12-09T12:05:29.192Z",
             "updateDate": "2022-06-30T14:16:46.047Z",
             "totalProducts": 7,
             "isActive": true,
             "subCategories": []
 */
