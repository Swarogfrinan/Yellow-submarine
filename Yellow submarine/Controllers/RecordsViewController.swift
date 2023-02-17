//
//  ResultViewController.swift
//  submarine
//
//  Created by Ilya Vasilev on 14.02.2022.
//

import UIKit
//таблица рекордов 
class RecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Let/var
    var records = RecordsManager.shared.loadRecords()
    let strOut = UserDefaults.standard.string(forKey: "name")
   
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
@IBOutlet weak var dateRecordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //загрузка времени забега
        if let strOut = UserDefaults.standard.string(forKey: "name") {
            print(strOut)
            dateRecordLabel.text = strOut
//            tableView.delegate = self
//            tableView.dataSource = self
        }
        
//загрузка результатов забега
guard let quantity = UserDefaults.standard.value(forKey: "quantity") as? String else  {return}
recordLabel.text = "Твой счёт последний счёт \(quantity)"
       
    }
    let data = Data()
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
    return records.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {
        
        return UITableViewCell()
    }
        if let recordDate = records[indexPath.row].date {
            print("Запись даты последнего рекорда \(recordDate)")
            cell.dateLabel.text = "\(recordDate)"
        }
    
        if let recordScore = records.sorted(by: {$0.score ?? 0 > $1.score ?? 0})[indexPath.row].score {
            print("Запись счёта последнего рекорда \(recordScore)")
            cell.scoreLabel.text = "\(recordScore)"
        }
    
   

      return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
    
    
//MARK: Extension
//extension TableResultVc: UITableViewDelegate, UITableViewDataSource {
 
//            guard let record = results else { return UITableViewCell() }
//            let result = results[indexPath.row]
//            cell.configure(
//                name: result.name,
//                score: "\(result.score)",
//                date: result.date
//                )

//}
    



