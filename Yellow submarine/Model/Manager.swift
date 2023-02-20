import UIKit

class Manager: StartGameViewController {
    //MARK: Let var
    var counter = 0
    static let shared = Manager()
    
}

//MARK: Extension + LaunchViewController
extension StartGameViewController {
    
    //MARK: Action
    func startPlayGame() {
        counter+=1
        switch counter % 2 {
        case 1 :
            UIView.animate(withDuration: 0.3) {
                self.playButton.alpha = 0
            }
            UIView.animate(withDuration: 2) {
                self.imageSubmarineView.frame.origin.x += 600
                
            } completion: {_ in
                UIView.animate(withDuration: 4) {
                    self.imageSubmarineView.isHidden = true
                    self.imageSubmarineView.frame.origin.x -= 600
                    self.imageSubmarineView.isHidden = false
                    self.playButton.alpha = 1
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                    return
                }
                controler.modalTransitionStyle = .flipHorizontal
                controler.modalPresentationStyle = .fullScreen
                self.present (controler, animated: true, completion: nil)
            }
        default :
            break
        }
    }
    func setAnimate() {
        launchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            UIView.animate(withDuration: 0.4) {
                self.imageSubmarineView.frame.origin.y -= 10
                self.fishImage.frame.origin.y -= 10
                self.fishSecondImage.frame.origin.y -= 5
                self.fishOneImage.frame.origin.y -= 5
                //    self.boatImage.transform = CGAffineTransform(rotationAngle: CGFloat(0.2 * Float.pi))
                //    self.boatImage.transform.rotated(by: 1)
                
                UIView.animate(withDuration: 0.4) {
                    self.imageSubmarineView.frame.origin.x -= 10
                    self.fishImage.frame.origin.x -= 10
                    self.fishSecondImage.frame.origin.x -= 5
                    self.fishOneImage.frame.origin.x -= 5
                    //               self.boatImage.transform = CGAffineTransform(rotationAngle: CGFloat(0.1 * Float.pi))
                    
                    
                } completion: {_ in
                    UIView.animate(withDuration: 0.4) {
                        self.imageSubmarineView.frame.origin.y += 10
                        self.imageSubmarineView.frame.origin.x += 10
                        self.fishImage.frame.origin.y += 10
                        self.fishImage.frame.origin.x += 10
                        self.fishSecondImage.frame.origin.y += 5
                        self.fishSecondImage.frame.origin.x += 5
                        self.fishOneImage.frame.origin.y += 5
                        self.fishOneImage.frame.origin.x += 5
                        //                   self.boatImage.transform = self.boatImage.transform.rotated(by: -1)
                        //                   self.boatImage.transform = CGAffineTransform(rotationAngle: CGFloat(0 * Float.pi))
                    }
                }
            }
            
        }
                                           
        )}
    
    
}





