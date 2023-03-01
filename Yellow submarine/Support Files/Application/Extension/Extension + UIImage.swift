import UIKit

//MARK: Extension + UIIMageView

extension UIImageView {

    func moveForward(completion : @escaping() -> ()) {
            self.isHidden = false
            UIView.animate(withDuration: 5, delay: 0.3) {
                self.frame.origin.x -= 900
            } completion: {_  in
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
               UIView.animate(withDuration: duration, delay: delay) {
                   self.frame.origin.x -= 900
               } completion: {_  in
                   self.isHidden = true
                   UIView.animate(withDuration: 0.4) {
                   self.frame.origin.x += 900
                   }
               }
           })
       }
    
    func setAfkAnimate(withDuration duration: Double, delay: Double) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.frame.origin.y -= 10
               UIView.animate(withDuration: duration, delay: delay) {
                   self.frame.origin.x -= 10
               } completion: {_  in
                   UIView.animate(withDuration: 0.4) {
                   self.frame.origin.x += 10
                    self.frame.origin.y += 10
                   }
               }
           })
       }
    
    func setAfkAnimateBoat(image: UIImageView) {
        UIView.animate(withDuration: 0.8) {
            image.transform = image.transform.rotated(by: 0.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.8) {
                image.transform = image.transform.rotated(by: -0.2)

            }
        }
        
    }
}

