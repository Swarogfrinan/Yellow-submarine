//
//  launchViewController.swift
//  submarine
//
//  Created by Ilya Vasilev on 26.01.2022.
//

import UIKit
//import CoreMedia
var counter : Int = 0
//MARK: Let var
var launchTimer = Timer()
let button = UIButton()
class launchViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var imageSubmarineView: UIImageView!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var fishSecondImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fishOneImage: UIImageView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPerson()
        setImage()
       setSubmarine()
//        setAnimate()
//        imageSubmarineView.dropShadow()
//        playButton.dropShadow()
        setupGesture()
    }
    
//MARK: Action
    func checkPerson() {
        let meduza = UIImage(named: "meduza")
        self.imageSubmarineView.image = meduza
    }

    func setSubmarine() {
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "image") as? String else  {return}
        if let image = SettingsViewController.loadImage(fileName: imageSubmarine) {
            imageSubmarineView.image = image
    }
    }
    
    func setImage() {
        let imageFishTwoLaunch = UIImage(named: "FishTwo")
        let imageSecond = UIImage(named: "FishSecond")
        let oneLaunch = UIImage(named: "fishOne")
        let imageBoat = UIImage(named: "boatShip")
        self.boatImage.image = imageBoat
        self.fishOneImage.image = oneLaunch
        self.fishSecondImage.image = imageSecond
        self.fishImage.image = imageFishTwoLaunch
    }

    //MARK: Navigation
    @IBAction func playButtonPressed(_ sender: UIButton) {
//        startPlayGame()
    }
    //add swipeGesture
    func setupGesture() {
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector (swipeAction))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
}
    //swipe navigation
    @objc private func swipeAction() {
//  startPlayGame()
}
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        
        controler.modalTransitionStyle = .crossDissolve
                controler.modalPresentationStyle = .fullScreen
                self.present (controler, animated: true, completion: nil)
    }
}
