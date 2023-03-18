import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    
    private var oxygenView = UIView()
    
    //MARK: Rotate Interface
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }
    
    //MARK: - IBOutlet Playing field
    @IBOutlet weak var topSkyView: UIView!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var botGroundView: UIView!
    
    @IBOutlet weak var dyingBlurView: UIVisualEffectView!
    @IBOutlet weak var resumeGameButton: UIButton!
    
    @IBOutlet weak var submarineView: UIView!
    
    @IBOutlet weak var swimUpButton: UIButton!
    @IBOutlet weak var swimDownButton: UIButton!
    @IBOutlet weak var pauseMusicButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    //MARK: - IBOutlet Game Enemies
    
    ///Player View
    @IBOutlet weak var submarinePlayerView: UIView!
    @IBOutlet weak var submarinePlayerImage: UIImageView!
    @IBOutlet weak var oxygenProgressView: UIProgressView!
    
    ///EnemiesView
    
    @IBOutlet weak var fishOneImage: UIImageView!
    @IBOutlet weak var fishSecondImage: UIImageView!
    @IBOutlet weak var boatShipImage: UIImageView!
    @IBOutlet weak var jellyfishImage: UIImageView!
    @IBOutlet weak var sharkImage: UIImageView!
    @IBOutlet weak var krakenImage: UIImageView!
    
    //MARK: TIMERS
    private var fishTimer = Timer()
    private var secondFishTimer = Timer()
    private var krakenTimer = Timer()
    private var jellyfishTimer = Timer()
    private var sharkTimer = Timer()
    private var boatTimer = Timer()
    private var oxygenTimer = Timer()
    
    
    
    //MARK: - State
    let settingsVC = SettingsViewController()
    let audioBrain = AudioBrain()
    private let gameTimer = TimerModel()
    let recordsManager = RecordsManager()
    var countFish : Int = 0
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        audioBrain.playerWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioBrain.switchPlayer()
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserSubmarine()
        setupOxygenbar()
        showFish()
        showSecondFish()
        showShark()
        showJellyfish()
        showBoat()
        showKraken()
    }
    
    //MARK: - Бар с кислородом
    
    
    
    //MARK: IBAction Methods
    
    @IBAction func swimUpButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.moveUpAndDown(directions: .up)
        }
    }
    
    @IBAction func swimDownButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.moveUpAndDown(directions: .down)
        }
    }
    
    @IBAction func resumeGameButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        recordsManager.saveGameResults(withCount: countFish)
        audioBrain.switchPlayer()
    }
    
    
    @IBAction func pauseMusicButtonPressed(_ sender: UIButton) {
        audioBrain.switchPlayer()
    }
}

//MARK: Private Methods

private extension GameViewController {
    
    func setupOxygenbar() {
        oxygenProgressView.setProgress(1, animated: false)
        oxygenTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            if self.oxygenProgressView.progress != 0 {
                UIView.animate(withDuration: 2) { [self] in
                    oxygenProgressView.progress -= 1 / 10
                    if submarinePlayerView.frame.origin.y < -150 {
                        oxygenProgressView.progress += 3/10
                    } else if submarinePlayerView.frame.origin.y >= 270 {
                        print("Death by reason - hitting the ground")
                        oxygenProgressView.progress = 0
                    }
                }
            }
            if self.oxygenProgressView.progress == 0 {
                UIView.animate(withDuration: 0.4) {
                    print("Death by reason - ran out of oxygen")
                    self.loseGame(life: false)
                }
            }
        }
        )}
    
    func loseGame(life : Bool) {
        if life {
            self.dyingBlurView.alpha = 0
        } else {
            invalidateGameTimers()
            self.dyingBlurView.alpha = 1
            print("Final count = \(countFish)")
        }
    }
    
    func invalidateGameTimers() {
        let timerArray = [fishTimer, secondFishTimer, boatTimer, sharkTimer, jellyfishTimer, krakenTimer, oxygenTimer]
        for timers in timerArray {
            timers.invalidate()
        }
    }
    
    
    
    //MARK: Появление существ
    
    func setupUserSubmarine() {
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "imageSubmarine") as? String else  {return}
        if let image = settingsVC.loadImage(fileName: imageSubmarine) {
            submarinePlayerImage.image = image
        }
    }
    
    func showFish() {
        fishTimer =  Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 6...20), repeats: true, block: { _ in
            self.fishOneImage.animateImageView(withDuration: 5, delay: 0.3, image: self.fishOneImage)
        })
    }
    func showSecondFish() {
        secondFishTimer =  Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 5...13), repeats: true, block: { _ in
            self.fishSecondImage.animateImageView(withDuration: 4, delay: 0.3, image: self.fishSecondImage)
            self.countFish += 1
            print("\(self.countFish) = secondFish")
        })
    }
    
    func showBoat() {
        boatTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 11...25), repeats: true, block: { _ in
            self.boatShipImage.animateImageView(withDuration: 7, delay: 0.3, image: self.boatShipImage)
            self.countFish += 1
            print("\(self.countFish) = Boat")
        })
    }
    
    func showShark() {
        sharkTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 18...45), repeats: true, block: { _ in
            self.sharkImage.animateImageView(withDuration: 13, delay: 0.7, image: self.sharkImage)
            self.countFish += 1
            print("\(self.countFish) = Shark")
        })
    }
    func showJellyfish() {
        jellyfishTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 11...43), repeats: true, block: { _ in
            self.jellyfishImage.animateImageView(withDuration: 4, delay: 0.2, image: self.jellyfishImage)
            self.countFish += 1
            print("\(self.countFish) = jellyfish")
        })
    }
    
    func showKraken() {
        krakenTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 80...120), repeats: true, block: { _ in
            self.krakenImage.animateImageView(withDuration: 25, delay: 6, image: self.krakenImage)
            self.countFish += 1
            print("\(self.countFish) = kraken")
        })
    }
}



