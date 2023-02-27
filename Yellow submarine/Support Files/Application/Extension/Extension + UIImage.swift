//
//  Extension + UIImage.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 02.09.2022.
//

import UIKit
//MARK: Extension + UIIMageView
extension UIImageView {
    ///Закругление изображения до состояния кружка.
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    func animated(duration : Int, delay : Double) -> () {
       
    }
    
    func moveForward(completion : @escaping() -> ()) {
            self.isHidden = false
            print("START")
            UIView.animate(withDuration: 5, delay: 0.3) {
                self.frame.origin.x -= 900
            } completion: {_  in
                print("COMPLETION")
                self.isHidden = true
                UIView.animate(withDuration: 0.4) {
                self.frame.origin.x += 900
                }
        }
    }
    
    func animate(withDuration duration: Double, animations: @escaping () -> Void) {
            UIView.animate(withDuration: duration, animations: {
                animations()
            })
        }
    
    func animateImageView(withDuration duration: Double, delay: Double, image: UIImageView) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
               self.isHidden = false
               print("START")
               UIView.animate(withDuration: duration, delay: delay) {
                   self.frame.origin.x -= 900
               } completion: {_  in
                   print("COMPLETION")
                   self.isHidden = true
                   UIView.animate(withDuration: 0.4) {
                   self.frame.origin.x += 900
                   }
               }
           })
       }
   

}

