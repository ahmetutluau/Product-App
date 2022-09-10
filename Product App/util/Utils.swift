//
//  Utils.swift
//  Product App
//
//  Created by MAC on 10.09.2022.
//

import UIKit

fileprivate var aView : UIView?

extension UIViewController {
    func showspinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            aView?.removeFromSuperview()
            aView = nil
        }
    }
    
    func showAlert(Title:String,Message:String) {
        let alertControl = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        
        let tamamAction = UIAlertAction(title: "Okey", style: .default) {
            action in
        }
        alertControl.addAction(tamamAction)
        
        self.present(alertControl, animated: true)
    }
    
}
