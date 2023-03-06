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
            if self.submarinePlayerView.frame.origin.y > -150 {
                self.submarinePlayerView.frame.origin.y -= distance
                self.oxygenProgressView.frame.origin.y -= distance
            }
            
        case .down:
            if self.submarinePlayerView.frame.origin.y < 280 {
                self.submarinePlayerView.frame.origin.y += distance
                self.oxygenProgressView.frame.origin.y += distance
            }
        }
    }
}

