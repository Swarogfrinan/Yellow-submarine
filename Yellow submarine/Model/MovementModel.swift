import UIKit

let distance: CGFloat = 50

extension GameViewController {
    
    enum Directions {
        case up
        case down
    }
    
    func moveUpAndDown(directions:Directions) {
        switch directions {
        case .up:
            UIView.animate(withDuration: 0.5) {
                if self.userSubmarineView.frame.origin.y > -140 {
                    self.userSubmarineView.frame.origin.y -= distance
                }
            }
        case .down:
            UIView.animate(withDuration: 0.5) {
                if self.userSubmarineView.frame.origin.y < 280 {
                    self.userSubmarineView.frame.origin.y += distance

                }
            }
        }
    }
}

