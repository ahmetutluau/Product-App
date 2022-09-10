//
//  UIImageViewExtension.swift
//  Product App
//
//  Created by MAC on 8.09.2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}




