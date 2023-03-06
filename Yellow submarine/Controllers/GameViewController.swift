import UIKit
import AVFoundation


enum lifeOrDead {
    case lifeOn
    case deadOff
}

class GameViewController: UIViewController {
    
    let settingsVC = SettingsViewController()
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
    private var lose = false
    private var flagFish = true
    private var flagBoat = true
    private var flagMove = true
    //    private var directions: Directions = .down
    
    //MARK: Аудиоплэйер
    private var audioPlayer = AVAudioPlayer()
    private var counter : Int = 0
    private var records = [Record]()
    private let gameTimer = GameTimer()
    
    //MARK: - Lifecycle
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "submarineOst", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            fatalError("Game music cannot be played")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSubmarine()
        self.showKraken()
        self.showFish()
        self.showSecondFish()
        self.showBoat()
        self.progressFunc()
     
        self.loseGame(lifeorDead: .lifeOn)
        
        self.showShark()
        self.showJellyfish()
        
    }
    
    //MARK: - Бар с кислородом
    
    func progressFunc() {
        oxygenProgressView.setProgress(1, animated: false)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            if self.oxygenProgressView.progress != 0 {
                UIView.animate(withDuration: 2) {
                    self.oxygenProgressView.progress -= 1 / 10
                    if self.submarinePlayerView.frame.origin.y < -150 {
                        self.oxygenProgressView.progress += 3/10
                    }
                }
            }
            if self.oxygenProgressView.progress == 0 {
                UIView.animate(withDuration: 1.5) {
                    self.loseGame(lifeorDead: .deadOff)
                }
            }
        }
        )}
    var isOxygenfull: Bool = true {
        didSet {
            if submarinePlayerView.frame.origin.y < -140 {
                self.oxygenProgressView.progress += 1
            }
        }
    }
    //MARK: Счетчик рыб
    
    var countFish : Int = 0 {
        didSet {
            countLabel.text = "Твой счёт \(countFish)"
        }
    }
    var life: Bool = true {
        didSet{
            //            checkIntersection()
            checkGroundIntersection()
        }
    }
    
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
        saveGameResults()
        self.dismiss(animated: true, completion: nil)
        audioPlayer.stop()
    }
    
    
    @IBAction func pauseMusicButtonPressed(_ sender: UIButton) {
        counter += 1
        switch counter % 3 {
        case 1 :
            audioPlayer.stop()
        case 2 :
            audioPlayer.play()
        default :
            break
        }
    }
    //MARK: Private Methods
    
    private func saveResultGame() {
        //дата рекорда
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let str = dateFormatter.string(from: Date())
        UserDefaults.standard.setValue(str, forKey: "name")
        
        //число рыб
        let quantity = countFish
        UserDefaults.standard.set(quantity, forKey: "quantity") //forkey - любой
    }
    private func loseGame(lifeorDead: lifeOrDead) {
        switch lifeorDead {
        case .lifeOn:
            lose = false
            self.dyingBlurView.alpha = 0
            self.resumeGameButton.alpha = 0
            
        case .deadOff:
            invalidateGameTimers()
            lose = true
            self.dyingBlurView.alpha = 1
            self.resumeGameButton.alpha = 1
            print("Final count = \(countFish)")
            saveResultGame()
            
        }
    }
    
    private func checkGroundIntersection() {
        
        if submarinePlayerView.frame.origin.y >= 270{
            lose = true
        }
        if submarinePlayerView.frame.origin.y + submarinePlayerView.frame.height >= self.gameView.frame.height {
            lose = true
        }
        if lose{
            loseGame(lifeorDead: .deadOff)
        }
    }
    
    private func saveGameResults() {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM, h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = .current
        let dateString = formatter.string(from: date)
        print(dateString)
        let newRecord = Record(score: countFish, date: dateString)
        RecordsManager.shared.saveRecords(newRecord)
        
        print("\(countFish) was saved to UserDefaults")
        
    }
    
    //MARK: Появление существ
    private func invalidateGameTimers() {
    let timerArray = [fishTimer, secondFishTimer, boatTimer, sharkTimer, jellyfishTimer, krakenTimer]
        for timers in timerArray {
            timers.invalidate()
        }
    }
    
    private  func showSubmarine() {
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "image") as? String else  {return}
        if let image = settingsVC.loadImage(fileName: imageSubmarine) {
            submarinePlayerImage.image = image
        }
    }
    
    private func showFish() {
        fishTimer =  Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 6...20), repeats: true, block: { _ in
            self.fishOneImage.animateImageView(withDuration: 5, delay: 0.3, image: self.fishOneImage)
        })
    }
    private func showSecondFish() {
        secondFishTimer =  Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 5...13), repeats: true, block: { _ in
            self.fishSecondImage.animateImageView(withDuration: 4, delay: 0.3, image: self.fishSecondImage)
            self.countFish += 1
            print("\(self.countFish) = secondFish")
        })
    }
    
    private func showBoat() {
        boatTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 11...25), repeats: true, block: { _ in
            self.boatShipImage.animateImageView(withDuration: 7, delay: 0.3, image: self.boatShipImage)
            self.countFish += 1
            print("\(self.countFish) = Boat")
        })
    }
    
    private func showShark() {
        sharkTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 18...45), repeats: true, block: { _ in
            self.sharkImage.animateImageView(withDuration: 13, delay: 0.7, image: self.sharkImage)
            self.countFish += 1
            print("\(self.countFish) = Shark")
        })
    }
    private func showJellyfish() {
       jellyfishTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 11...43), repeats: true, block: { _ in
            self.jellyfishImage.animateImageView(withDuration: 4, delay: 0.2, image: self.jellyfishImage)
            self.countFish += 1
            print("\(self.countFish) = jellyfish")
        })
    }
    
    private func showKraken() {
     krakenTimer = Timer.scheduledTimer(withTimeInterval: gameTimer.randomTimerNumber(in: 80...120), repeats: true, block: { _ in
            self.krakenImage.animateImageView(withDuration: 25, delay: 6, image: self.krakenImage)
            self.countFish += 1
            print("\(self.countFish) = kraken")
        })
    }
}



