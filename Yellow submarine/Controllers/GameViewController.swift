import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    //MARK: Auto-Rotate Interface
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
    
    //MARK: - Constant
    private let settingsVC = SettingsViewController()
    private let audioPlayerModel = AudioPlayerModel()
    private var timerModel = TimerModel()
    private let recordsManager = RecordsManager()
    private  var countFish : Int = 0
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        audioPlayerModel.playerWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioPlayerModel.switchPlayer()
    }
    
    //MARK: - viewDidLoad
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
    
    //MARK: IBAction Methods
    
    @IBAction func swimUpButtonPressed(_ sender: UIButton) {
        sender.startAnimatingPressActions()
            self.moveUpAndDown(directions: .up)
    }
    
    @IBAction func swimDownButtonPressed(_ sender: UIButton) {
        sender.startAnimatingPressActions()
            self.moveUpAndDown(directions: .down)
    }
    
    @IBAction func resumeGameButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        sender.startAnimatingPressActions()
        recordsManager.saveGameResults(withCount: countFish)
        audioPlayerModel.switchPlayer()
    }
    
    
    @IBAction func pauseMusicButtonPressed(_ sender: UIButton) {
        if audioPlayerModel.audioPlayer.isPlaying {
            sender.setImage(UIImage(systemName: "volume.slash"), for: .normal)
            sender.setTitle("Stop", for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "volume.2"),for: .normal)
            sender.setTitle("Play", for: .normal)
        }
        sender.startAnimatingPressActions()
        audioPlayerModel.switchPlayer()
    }
}

//MARK: Private Methods

private extension GameViewController {
    
    func loseGame(alive : Bool) {
        if alive {
            self.dyingBlurView.alpha = 0
        } else {
            timerModel.invalidateGameTimers()
            self.dyingBlurView.alpha = 1
            print("Final game count = \(countFish)")
        }
    }
    
    //MARK: Появление существ
    
    func setupUserSubmarine() {
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "imageSubmarine") as? String else  {return}
        if let image = settingsVC.loadImage(fileName: imageSubmarine) {
            submarinePlayerImage.image = image
        }
    }
    
    func setupOxygenbar() {
        oxygenProgressView.setProgress(1, animated: false)
        
        timerModel.oxygenTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            
            if self.oxygenProgressView.progress != 0 {
                UIView.animate(withDuration: 2) { [self] in
                    oxygenProgressView.progress -= 1 / 10
                    if submarinePlayerView.frame.origin.y < -150 {
                        oxygenProgressView.progress += 3/10
                    }
                }
            }
            
            if self.oxygenProgressView.progress == 0 ||  self.submarinePlayerView.frame.origin.y >= 270 {
                UIView.animate(withDuration: 0.4) {
                    print("Death by reason - ran out of oxygen")
                    self.loseGame(alive: false)
                }
            }
        }
        )}
    
    
    func showFish() {
        timerModel.fishTimer =  Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 6...20), repeats: true, block: { _ in
            self.fishOneImage.animateImageView(withDuration: 5, delay: 0.3, image: self.fishOneImage)
        })
    }
    
    func showSecondFish() {
        timerModel.secondFishTimer =  Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 5...13), repeats: true, block: { _ in
            self.fishSecondImage.animateImageView(withDuration: 4, delay: 0.3, image: self.fishSecondImage)
            self.countFish += 1
            print("\(self.countFish) = secondFish")
        })
    }
    
    func showBoat() {
        timerModel.boatTimer = Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 11...25), repeats: true, block: { _ in
            self.boatShipImage.animateImageView(withDuration: 7, delay: 0.3, image: self.boatShipImage)
            self.countFish += 1
            print("\(self.countFish) = Boat")
        })
    }
    
    func showShark() {
        timerModel.sharkTimer = Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 18...45), repeats: true, block: { _ in
            self.sharkImage.animateImageView(withDuration: 13, delay: 0.7, image: self.sharkImage)
            self.countFish += 1
            print("\(self.countFish) = Shark")
        })
    }
    func showJellyfish() {
        timerModel.jellyfishTimer = Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 11...43), repeats: true, block: { _ in
            self.jellyfishImage.animateImageView(withDuration: 4, delay: 0.2, image: self.jellyfishImage)
            self.countFish += 1
            print("\(self.countFish) = jellyfish")
        })
    }
    
    func showKraken() {
        timerModel.krakenTimer = Timer.scheduledTimer(withTimeInterval: timerModel.randomTimerNumber(in: 80...120), repeats: true, block: { _ in
            self.krakenImage.animateImageView(withDuration: 25, delay: 6, image: self.krakenImage)
            self.countFish += 1
            print("\(self.countFish) = kraken")
        })
    }
}



