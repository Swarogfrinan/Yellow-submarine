import UIKit

class StartGameViewController: UIViewController {
    
    // MARK: - Constans
    let settingsVc = SettingsViewController()
    var timerModel = TimerModel()
    // MARK: - IBOutlet
    @IBOutlet weak var playerSubmarineImage: UIImageView!
    @IBOutlet weak var boatImage: UIImageView!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var secondFishImage: UIImageView!
    @IBOutlet weak var thirdFishImage: UIImageView!
    @IBOutlet weak var kracenImage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        setSubmarineFromSettings()
        playButton.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        showCracen()
        setupGesture()
        playerSubmarineImage.dropShadow()
        playButton.dropShadow()
    }
    
    
    //MARK: IBAction Methods
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        startPlayGame()
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        guard let controller = UIStoryboard(name: "SettingsViewController", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
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
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "imageSubmarine") as? String else  { return }
        if let image = settingsVc.loadImage(fileName: imageSubmarine) {
            playerSubmarineImage.image = image
        }
    }
    private func setupAnimations() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] _ in
            playerSubmarineImage.setAfkAnimate(withDuration: 0.4)
            fishImage.setAfkAnimate(withDuration: 0.4)
            secondFishImage.setAfkAnimate(withDuration: 0.4)
            thirdFishImage.setAfkAnimate(withDuration: 0.4)
        })
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.boatImage.setAfkAnimateBoat(image: self.boatImage)
        }
    }
    
    private func showCracen() {
        Timer.scheduledTimer(withTimeInterval: 25, repeats: true) { _ in
            self.kracenImage.animateKracen(withDuration: 19, delay: 0, image: self.kracenImage)
            }
    }
    
    private func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector (swipeAction))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    func startPlayGame() {
        UIView.animate(withDuration: 0.5) {
            self.playButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 2) {
                self.playerSubmarineImage.frame.origin.x += 900
            }
        }
        goToGameViewController()
    }
    
    func goToGameViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            guard let controller = UIStoryboard(name: "GameViewController", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else {
                return
            }
            
            controller.modalTransitionStyle = .flipHorizontal
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }
}


