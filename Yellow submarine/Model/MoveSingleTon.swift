//
//  Func.swift
//  submarine
//
import Foundation
import UIKit
let distance: CGFloat = 50
//  Created by Ilya Vasilev on 01.02.2022.
extension MainViewController {
enum Directions {
case up
    case down

}


func moveUpAndDown(directions:Directions) {
switch directions {
                          case .up:
if self.submarineView.frame.origin.y > -150 {
self.submarineView.frame.origin.y -= distance
self.oxygenProgressView.frame.origin.y -= distance
}

                          case .down:
if self.submarineView.frame.origin.y < 280 {
self.submarineView.frame.origin.y += distance
self.oxygenProgressView.frame.origin.y += distance
}

    
}
}
}

