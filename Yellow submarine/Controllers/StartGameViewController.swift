import UIKit



class StartGameViewController: UIViewController {
    
    // MARK: - Constans
    var counter : Int = 0
    // MARK: - IBOutlet
    
    @IBOutlet weak var playerSubmarineImage: UIImageView!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var secondFishImage: UIImageView!
    @IBOutlet weak var thirdFishImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubmarineFromSettings()
        setupAnimation()
        setupGesture()
        playerSubmarineImage.dropShadow()
        playButton.dropShadow()
    }
    
    
    //MARK: IBAction Methods
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startPlayGame()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        self.present (controller, animated: true, completion: nil)
    }
}


//MARK: - Methods

private extension StartGameViewController {
    
    @objc private func swipeAction() {
        startPlayGame()
    }
    private func setSubmarineFromSettings() {
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "submarineImage") as? String else  { return }
        if let image = SettingsViewController.loadImage(fileName: imageSubmarine) {
            playerSubmarineImage.image = image
        }
    }
    private func setupAnimation() {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            playerSubmarineImage.setAfkAnimate(withDuration: 0.4, delay: 0)
            fishImage.setAfkAnimate(withDuration: 0.4, delay: 0)
            secondFishImage.setAfkAnimate(withDuration: 0.4, delay: 0)
            thirdFishImage.setAfkAnimate(withDuration: 0.4, delay: 0)
        })
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.boatImage.setAfkAnimateBoat(image: self.boatImage)
        }
    }
    
    private func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector (swipeAction))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    func startPlayGame() {
        counter += 1
        switch counter % 2 {
        case 1 :
            UIView.animate(withDuration: 0.3) {
                self.playButton.alpha = 0
            }
            
            UIView.animate(withDuration: 2) {
                self.playerSubmarineImage.frame.origin.x += 600
            } completion: {_ in
                UIView.animate(withDuration: 4) {
                    self.playerSubmarineImage.isHidden = true
                    self.playerSubmarineImage.frame.origin.x -= 600
                    self.playerSubmarineImage.isHidden = false
                    self.playButton.alpha = 1
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                    return
                }
                
                controller.modalTransitionStyle = .flipHorizontal
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
        default :
            break
        }
    }
}


