import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var firstSubmarineButton: UIButton!
    @IBOutlet weak var secondSubmarineButton: UIButton!
    @IBOutlet weak var thirdSubmarineButton: UIButton!
    @IBOutlet weak var goToRecordsButton: UIButton!
    
    @IBOutlet weak var submarineFirstImage: UIImageView!
    @IBOutlet weak var submarineSecondImage: UIImageView!
    @IBOutlet weak var submarineThirdImage: UIImageView!
    
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpAnimation()
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func submarineButtonOnePressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarine") {
            let imageSubmarine = saveImage(image: image)
            UserDefaults.standard.set(imageSubmarine, forKey: "imageSubmarine")
            submarineFirstImage.setAfkAnimate(withDuration: 0.4)
        }
    }
    
    @IBAction func submarineButtonTwoPressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarineTwo") {
            let imageSubmarine = saveImage(image: image)
            UserDefaults.standard.set(imageSubmarine, forKey: "imageSubmarine")
            submarineSecondImage.setAfkAnimate(withDuration: 0.4)
            
        }
    }
    
    @IBAction func submarineButtonThreePressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarineThree") {
            let imageSubmarine = saveImage(image: image)
            UserDefaults.standard.set(imageSubmarine, forKey: "imageSubmarine")
            submarineThirdImage.setAfkAnimate(withDuration: 0.4)
        }
    }
    
    @IBAction func goToRecordsButtonPressed(_ sender: UIButton) {
        guard let controler = UIStoryboard(name: "RecordsViewController", bundle: nil).instantiateViewController(withIdentifier: "RecordsViewController") as? RecordsViewController else {
            return
        }
        controler.modalTransitionStyle = .crossDissolve
        controler.modalPresentationStyle = .fullScreen
        self.present (controler, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: -  Methods
    
    private func saveImage (image: UIImage) -> String? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = UUID().uuidString
        let fileURl = documentDirectory.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return nil }
        
        if FileManager.default.fileExists(atPath: fileURl.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURl.path)
                print("Removed old user skin")
            } catch let error {
                print("Couldnt remove file at path", error)
            }
        }
        do {
            try data.write(to: fileURl)
            return fileName
        } catch let error {
            print("Eror saving file with error", error)
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageUrl = documentDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        } else {
            return nil
        }
    }
    private func popUpAnimation() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [self] _ in
            submarineFirstImage.popUpAnimation(withDuration: 2)
            submarineSecondImage.popUpAnimation(withDuration: 3)
            submarineThirdImage.popUpAnimation(withDuration: 3.5)
        }
    }
}
