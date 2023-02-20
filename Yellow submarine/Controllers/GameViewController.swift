import UIKit
import AVFoundation


enum lifeOrDead {
    case lifeOn
    case deadOff
}

class GameViewController: UIViewController{
    
    let fishArray = ["fishOne", "fishSecond"]
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

    //MARK: IBOutlet
    //setup View
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var centralPlayView: UIView!
    @IBOutlet weak var buttonsBorderView: UIView!
    
    @IBOutlet weak var groundView: UIView!
    @IBOutlet weak var oceanView: UIView!
    @IBOutlet weak var boatView: UIView!
    @IBOutlet weak var skyView: UIView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var fishTwoView: UIView!
    @IBOutlet weak var fishOneView: UIView!
    @IBOutlet weak var submarineView: UIView!
    @IBOutlet weak var upButtonbutton: UIButton!
    @IBOutlet weak var downButtonbutton: UIButton!
    @IBOutlet weak var behaviorSubmarine: UIView?
    @IBOutlet weak var behaviorFishOne: UIView?
    @IBOutlet weak var visualEffectBlur: UIVisualEffectView!
    @IBOutlet weak var countLabel: UILabel!
    //MARK: IBOutlet images
    
    
    @IBOutlet weak var fishTwoImage: UIImageView!
    @IBOutlet weak var fishOneImage: UIImageView!
    @IBOutlet weak var submarineImage: UIImageView!
    @IBOutlet weak var boatShipImage: UIImageView!
    @IBOutlet weak var oceanFoneImage: UIImageView!
    @IBOutlet weak var groundFoneImage: UIImageView!
    @IBOutlet weak var buttonUpImage: UIImageView!
    @IBOutlet weak var buttonDownImage: UIImageView!
    @IBOutlet weak var oxygenProgressView: UIProgressView!
    @IBOutlet var UILongPressGestureOutlet: UILongPressGestureRecognizer!
    //29.01 resume button
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var buttonResume: UIView!
    @IBOutlet weak var buttonResumeDopVIew: UIView!
    @IBOutlet weak var krakenImage: UIImageView!
    @IBOutlet weak var meduzaImage: UIImageView!
    @IBOutlet weak var sharkImage: UIImageView!
    
    
    //MARK: let/var
    
    //MARK: TIMERS
    private var KrakenTimer = Timer()
    private var MeduzaTimer = Timer()
    private var SharkTimer = Timer()
    private var oxygenTimer = Timer()
    private var fishTimer = Timer()
    private var fishTimerSecond = Timer()
    private var boatTimer = Timer()
    private var oxygenView = UIView()
    private var directions: Directions = .down
    private var lose = false
    //     let distance: CGFloat = 50
    private var flagFish = true
    private var flagBoat = true
    private var flagMove = true
    
    
    //зачем? столкновения
    var animator: UIDynamicAnimator?
    //MARK: Столкновения
    //попытка сделать столкновения
    @IBOutlet var obstact: [UIView]!
    
    //MARK: Аудиоплэйер
    var audioPlayer = AVAudioPlayer()
    //MARK: Появление существ
    
    private  func showSubmarine() {
        //                          let submarineViewPersonal = UIImage(named: "image")
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "image") as? String else  {return}
        if let image = SettingsViewController.loadImage(fileName: imageSubmarine) {
            submarineImage.image = image
        }
    }
    //MARK: Show First Fish
    private func showFish() {
        fishOneImage.dropShadow()
        fishTimer = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 9...15), repeats: true, block: { _ in
            let imageFish = UIImage(named: "fishOne")
            self.fishOneImage?.image = imageFish
            self.fishOneImage.isHidden = false
            UIView.animate(withDuration: 5, delay: 0.3) {
                self.fishOneImage.frame.origin.x -= 900
            } completion: {_ in
                self.fishOneImage.isHidden = true
                UIView.animate(withDuration: 0.4) {
                    self.fishOneImage.frame.origin.x += 900
                    
                    self.countFish += 1
                    //              self.countLabel.text = "Твой счёт \(self.countFish)"
                }
            }
        }
        )}
    //MARK: Show Second Fish
    private func showTwoFish() {
        fishTwoImage.dropShadow()
        fishTimerSecond = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 11...16), repeats: true, block: { _ in
            let imageTwoFish = UIImage(named: "FishTwo")
            self.fishTwoImage.image = imageTwoFish
            self.fishTwoImage.isHidden = false
            UIView.animate(withDuration: 7, delay: 0.6, options: UIView.AnimationOptions.curveEaseIn) {
                self.fishTwoImage.frame.origin.x -= 900
            } completion: {_ in
                self.fishTwoImage.isHidden = true
                UIView.animate(withDuration: 0.2) {
                    self.fishTwoImage.frame.origin.x += 900
                    
                    self.countFish += 1
                }
            }
        }
        )}
    
    //MARK: Show Boat
    private func showBoat() {
        boatShipImage.dropShadowboat()
        boatTimer = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 11...25), repeats: true, block: { _ in
            let imageBoat = UIImage(named: "boatShip")
            self.boatShipImage.image = imageBoat
            self.boatShipImage.isHidden = false
            //let height = CGFloat.random(in: 70...self.view.frame.height / 3.5)
            //let width = height * 1.5
            //let x = self.view.frame.width
            //let y = self.view.frame.height
            //let boat = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
            //self.view.addSubview(boat)
            UIView.animate(withDuration: 7, delay: 1) {
                self.boatShipImage.frame.origin.x -= 900
                //                   obstaclesArray.append(boatView)
                
            } completion: {_ in
                self.boatShipImage.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.boatShipImage.frame.origin.x += 900
                    self.countFish += 1
                }
            }
        }
        )}
    //MARK: Show Shark
    private func showShark() {
        sharkImage.dropShadow()
        SharkTimer = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 18...45), repeats: true, block: { _ in
            let imageSharked = UIImage(named: "Shark")
            self.sharkImage.image = imageSharked
            self.sharkImage.isHidden = false
            UIView.animate(withDuration: 13, delay: 1) {
                self.sharkImage.frame.origin.x -= 900
            } completion: {_ in
                self.sharkImage.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.sharkImage.frame.origin.x += 900
                    
                    self.countFish += 1
                    
                }
            }
        }
        )}
    
    //MARK: Show Meduza
    private func showMeduza() {
        meduzaImage.dropShadow()
        MeduzaTimer = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 11...43), repeats: true, block: { _ in
            let imageMeduza = UIImage(named: "meduza")
            self.meduzaImage.image = imageMeduza
            self.meduzaImage.isHidden = false
            UIView.animate(withDuration: 4, delay: 1) {
                self.meduzaImage.frame.origin.x -= 900
            } completion: {_ in
                self.meduzaImage.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.meduzaImage.frame.origin.x += 900
                    
                    self.countFish += 1
                    
                }
            }
        }
        )}
    
    //MARK: Show Kracen
    private func showKracen() {
        krakenImage.dropShadow()
        KrakenTimer = Timer.scheduledTimer(withTimeInterval: randomTimerNumber(in: 80...120), repeats: true, block: { _ in
            let imageKraken = UIImage(named: "Kracen")
            self.krakenImage.image = imageKraken
            self.krakenImage.isHidden = false
            UIView.animate(withDuration: 35, delay: 6) {
                self.krakenImage.frame.origin.x -= 900
            } completion: {_ in
                self.krakenImage.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    self.krakenImage.frame.origin.x += 900
                    self.countFish += 1
                }
            }
        }
        )}
    
    //MARK: RandomsNumbers
    func randomDuration(in range: ClosedRange<Double>) -> Double {
        return(Double.random(in: 3...12))
    }
    func randomTimerNumber(in range: ClosedRange<Double>) -> Double {
        return(Double.random(in: 11...120))
    }
    
    //MARK: lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //animated
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //        var collisionBehavior: UICollisionBehavior
        
        let Boundries = UICollisionBehavior (items: [behaviorSubmarine!, behaviorFishOne!])
        Boundries.translatesReferenceBoundsIntoBoundary = true
        let gravity = UIGravityBehavior(items: [behaviorSubmarine!, behaviorFishOne!])
        let directions = CGVector(dx: 0, dy: 0)
        gravity.gravityDirection = directions
        animator?.addBehavior(Boundries)
        animator?.addBehavior(Boundries)
        //        collisionBehavior = UICollisionBehavior(items: [])
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "submarineOst", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }catch{
        }
        
        //MARK: Запуск всего
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        showSubmarine()
        self.showKracen()
        self.showFish()
        self.showTwoFish()
        self.showBoat()
        self.progressFunc()
        oxygenProgressView.setProgress(1, animated: false)
        self.loseGame(lifeorDead: .lifeOn)
        //                 self.visualEffectBlur.alpha = 0
        //                 self.buttonResumeDopVIew.alpha = 0
        //        self.visualEffectBlur.isHidden = true
        //        self.buttonResumeDopVIew.isHidden = true
        self.showShark()
        self.showMeduza()
        //      isOxygenfull = true
    }
    //MARK: Бар с кислородом
    func progressFunc() {
        oxygenTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            if self.oxygenProgressView.progress != 0 {
                UIView.animate(withDuration: 2) {
                    self.oxygenProgressView.progress -= 1 / 10
                    if self.submarineView.frame.origin.y < -150 {
                        self.oxygenProgressView.progress += 3/10
                    }
                    
                }
            }
            //MARK: Кончился кислород
            if self.oxygenProgressView.progress == 0 {
                //                self.visualEffectBlur.isHidden = false
                //                self.buttonResumeDopVIew.isHidden = false
                UIView.animate(withDuration: 1.5) {
                    //                         self.visualEffectBlur.alpha = 1
                    //                         self.buttonResumeDopVIew.alpha = 1
                    self.loseGame(lifeorDead: .deadOff)
                }
            }
        }
        )}
    //MARK: Пополнение кислорода
    var isOxygenfull: Bool = true {
        didSet {
            if submarineView.frame.origin.y < -140 {
                self.oxygenProgressView.progress += 1
            }
        }
    }
    //MARK: Счетчик рыб
    var countFish : Int = 0 {
        didSet {
            countLabel.text = "Твой счёт \(countFish)"
            print(countFish)
            
        }
    }
    var life: Bool = true {
        didSet{
            checkIntersection()
            checkGroundIntersection()
        }
    }
    
    
    
    
    //MARK: Кнопка ВВЕРХ
    @IBAction func upButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.moveUpAndDown(directions: .up)
        }
    }
    
    //MARK: Кнопка ВНИЗ
    @IBAction func DownButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.moveUpAndDown(directions: .down)
        }
    }
    
    func ResultSchore() {
        //дата рекорда
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let str = dateFormatter.string(from: Date())
        UserDefaults.standard.setValue(str, forKey: "name")
        
        //число рыб
        let quantity = countFish
        UserDefaults.standard.set(quantity, forKey: "quantity") //forkey - любой
    }
    
    
    //29.01
    //MARK: конец игры
    func loseGame(lifeorDead: lifeOrDead) {
        switch lifeorDead {
        case .lifeOn:
            lose = false
            self.visualEffectBlur.alpha = 0
            self.buttonResumeDopVIew.alpha = 0
        case .deadOff:
            lose = true
            self.visualEffectBlur.alpha = 1
            self.buttonResumeDopVIew.alpha = 1
            print(countFish)
            ResultSchore()
            
        }
    }
    
    private func checkIntersection() {
        //for obstacle in obstaclesArray {
        if let submarineFrame = submarineView.layer.presentation()?.frame{
            if let BoatFrame = boatView.layer.presentation()?.frame{
                if let KrakenFrame = krakenImage.layer.presentation()?.frame{
                    if let FishFrame = fishOneView.layer.presentation()?.frame{
                        if submarineFrame.intersects(BoatFrame) || submarineFrame.intersects(KrakenFrame) || submarineFrame.intersects(FishFrame)  {
                            lose=true
                        }
                        if lose {
                            loseGame(lifeorDead: .deadOff)
                        }
                    }
                }
            }
        }
    }
    //}
    func checkGroundIntersection() {
        
        if submarineView.frame.origin.y >= 270{
            lose = true
        }
        if submarineView.frame.origin.y + submarineView.frame.height >= self.centralPlayView.frame.height {
            lose = true
        }
        if lose{
            loseGame(lifeorDead: .deadOff)
        }
    }
    func saveGameResults() {
        
        let date = Date()
        let formatter = DateFormatter()
        //        formatter.dateFormat = "MM dd, h:mm"
        formatter.dateFormat = "dd/MM, h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = .current
        let dateString = formatter.string(from: date)
        print(dateString)
        let newRecord = Record(score: countFish, date: dateString)
        RecordsManager.shared.saveRecords(newRecord)
        
        print("\(countFish) was saved to UD")
        
    }
    
    var records = [Record]()
    @IBAction func resumeButtomPressed(_ sender: UIButton) {
        saveGameResults()
        self.dismiss(animated: true, completion: nil)
        audioPlayer.stop()
    }
    
    
    //MARK: Кнопка Музыка (Resume and stop)
    var counter : Int = 0
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        counter+=1
        switch counter % 3 {
        case 1:
            audioPlayer.stop()
        case 2:
            audioPlayer.play()
        default :
            break
            
        }
        
        //    let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(addAnotation(press:)))
        //    longPressGestureRecogn.minimumPressDuration = 1.0
        //    submarineView.addGestureRecognizer(longPressGestureRecogn)
        //}
        //
        //    func addAnotation (press:UILongPressGestureRecognizer) {
        //        if press.state ==.began {
        //        {
        //            let location = press.location(in: mainView)
        //            let coordinates = mainView.convert(location, toCoordinateFrom : mainView)
        //            let annotation =
        //
        //        }
        //
        //
        
        
    }
}

