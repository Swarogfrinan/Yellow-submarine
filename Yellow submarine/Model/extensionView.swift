import Foundation
import UIKit


extension UIView {
    
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
