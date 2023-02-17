//
//  SettingsViewController.swift
//  submarine
//
//  Created by Ilya Vasilev on 02.02.2022.
//

import UIKit
enum SubmarineSelected {
    case one
    case two
    case three
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var submarineSettingsOneView: UIView!
    @IBOutlet weak var submarineSettingsTwoView: UIView!
    @IBOutlet weak var submarineSettingsThreeView: UIView!
    
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
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Кнопки сохранения выбора подлодки
    @IBAction func submarineButtonOnePressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarine") {
            let imageSubmarine = SettingsViewController.saveImage(image: image)
                    UserDefaults.standard.set(imageSubmarine, forKey: "image")
            UIView.animate(withDuration: 0.4) {
                self.submarineSettingsOneView.frame.origin.y -= 10
                           UIView.animate(withDuration: 0.4) {
                               self.submarineSettingsOneView.frame.origin.x -= 10
                           } completion: {_ in
                               UIView.animate(withDuration: 0.4) {
                                   self.submarineSettingsOneView.frame.origin.y += 10
                                              UIView.animate(withDuration: 0.4) {
                                                  self.submarineSettingsOneView.frame.origin.x += 10
        }
    }
        }
    }
        }
    }
    @IBAction func submarineButtonTwoPressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarineTwo") {
            let imageSubmarine = SettingsViewController.saveImage(image: image)
                    UserDefaults.standard.set(imageSubmarine, forKey: "image")
            UIView.animate(withDuration: 0.4) {
                self.submarineSettingsTwoView.frame.origin.y -= 10
                           UIView.animate(withDuration: 0.4) {
                               self.submarineSettingsTwoView.frame.origin.x -= 10
                           } completion: {_ in
                               UIView.animate(withDuration: 0.4) {
                                   self.submarineSettingsTwoView.frame.origin.y += 10
                                              UIView.animate(withDuration: 0.4) {
                                                  self.submarineSettingsTwoView.frame.origin.x += 10
        }
    }
        }
    }
        }
    }
    @IBAction func submarineButtonThreePressed(_ sender: UIButton) {
        if let image = UIImage(named: "submarineThree") {
            let imageSubmarine = SettingsViewController.saveImage(image: image)
                    UserDefaults.standard.set(imageSubmarine, forKey: "image")
            UIView.animate(withDuration: 0.4) {
                self.submarineSettingsThreeView.frame.origin.y -= 10
                           UIView.animate(withDuration: 0.4) {
                               self.submarineSettingsThreeView.frame.origin.x -= 10
                           } completion: {_ in
                               UIView.animate(withDuration: 0.4) {
                                   self.submarineSettingsThreeView.frame.origin.y += 10
                                              UIView.animate(withDuration: 0.4) {
                                                  self.submarineSettingsThreeView.frame.origin.x += 10
        }
    }
        }
    }
        }
    }
    //MARK: Navigation
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        guard let controler = self.storyboard?.instantiateViewController(withIdentifier: "TableResultVc") as? RecordsViewController else {
            return
    }
        //Screen rotate
        controler.modalTransitionStyle = .crossDissolve
                controler.modalPresentationStyle = .fullScreen
                self.present (controler, animated: true, completion: nil)
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        guard let imageSubmarine = UserDefaults.standard.value(forKey: "image") as? String else  {return}
        if let image = SettingsViewController.loadImage(fileName: imageSubmarine) {
        
        
        }
}

        // Задаём скин-игрока в настройках, сохраняем его.
       static func saveImage (image: UIImage) -> String? {
                guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
         //путь к папке приложения где оно сохраняет файлы
                let fileName = UUID().uuidString
        // создали имя файла
                let fileURl = documentDirectory.appendingPathComponent(fileName) // создали путь к этому файлу
                guard let data = image.pngData() else { return nil } // конвертировали картинку в DATA
                
                //Проверка есть ли файл по заданному пути - если есть, удалить. Не вышло - перехватываем ошибку методом do catch.
                if FileManager.default.fileExists(atPath: fileURl.path) {
                    do {
                        try FileManager.default.removeItem(atPath: fileURl.path)
                            print("Removed old images")
                        } catch let error {
                            print("couldnt remove file at path", error)
                        }
                    }
                    // записали дату вместо имени файла
                do {
            try data.write(to: fileURl)
            return fileName
                } catch let error {
                    print("Eror saving file with error", error)
            return nil
                }
            }
    
    
    
    
    //Установка скина-игрока  SettingsVC
    
                // задаём имя файла, пытаемся вернуть картинку.
          static  func loadImage(fileName: String) -> UIImage? {
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    // путь к папке проекта
                    let imageUrl = documentDirectory.appendingPathComponent(fileName)
                    //путь к файлу
            let image = UIImage(contentsOfFile: imageUrl.path)
                    // читает содержимое файла
                    
            return image
        }
                
        // неудача - возвращаем ноль
            return nil
                
            }
    
}
    
    
    





//let imageArray = [submarineImage,fishImage,fishOneImage]
//    let submarineImageOne = UIImage (named: "submarine")
//    let submarineImageTwo = UIImage (named: "submarineTwo")
//    let submarineImageThree = UIImage (named: "submarineThree")
//    let exersiseImage = ["submarine", "submarineTwo", "submarineThree"]


//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { let OptionsViewController: MainViewController = segue.op as! MainViewController, OptionsViewController.exersiseImage = exersiseImage
//
//        private func getSettings() {
//            guard let defaults = UserDefaults.standard.value
//        }
//        guard let text = nameFied.text else {return}
//        settings = Settings(submarine: submarineSelected, name: text)
//        UserDefaults.standard.set



//@IBAction func switchSubmarineSkin() {
////            changesMade = true
////            savePressed = false
//            switch SubmarineSelected {
//            case .one:
//                self.submarineView = .one
//                guard let image = exersiseImage[submarineImageOne] else {return}
//                submarineSelectView.image = image
//            case .two:
//                submarineSelected = .two
//                guard let image = submarineSkins[submarineSelected] else {return}
//            case .three:
//                submarineSelected = .three
//                guard let image = submarineSkins[submarineSelected] else {return}
//            }
//        }
//}
