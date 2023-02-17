//
//  extensionView.swift
//  submarine
//
//  Created by Ilya Vasilev on 28.01.2022.
//

import Foundation
import UIKit
//extension теней
extension UIView {
//func rounded(radius: CGFloat = 10) {
// self.layer.cornerRadius = radius
    func dropShadow() {
    layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 10, height: 10)
    layer.shadowRadius = 15
           
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width/2).cgPath
    layer.shouldRasterize = true
}

    func dropShadowboat() {
    layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
    layer.shadowOffset = CGSize(width: 0, height: -10)
    layer.shadowRadius = 12
           
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.width/2).cgPath
    layer.shouldRasterize = true
}
    
}
