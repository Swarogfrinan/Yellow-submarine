import UIKit

class RecordsViewController: UIViewController {
    
    //MARK: Constant
    let data = Data()
    var manager = RecordsManager()
    let strOut = UserDefaults.standard.string(forKey: "strOut")
    
    //MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var countRecordLabel: UILabel!
    @IBOutlet weak var dateRecordLabel: UILabel!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //загрузка времени забега
        if let strOut = UserDefaults.standard.string(forKey: "strOut") {
            print(strOut)
            dateRecordLabel.text = strOut
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        //загрузка результатов забега
        guard let count = UserDefaults.standard.value(forKey: "count") as? String else  {return}
        countRecordLabel.text = "Твой счёт последний счёт \(count)"
        
    }
    
    //MARK: IBA Methods
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension RecordsViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return records.count
        return manager.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {
            
            return UITableViewCell()
        }
        if let recordDate = manager.records[indexPath.row].date {
            print("Запись даты последнего рекорда \(recordDate)")
            cell.dateLabel.text = "\(recordDate)"
        }
        //        if let recordScore = manager.records.sorted(by: {$0.score > $1.score })[indexPath.row].score {
         let recordScore = manager.records[indexPath.row].score as? Int
        if recordScore != nil {
            print("Запись счёта последнего рекорда \(recordScore)")
            cell.scoreLabel.text = "\(recordScore)"
        }
        
        return cell
    }
}

extension RecordsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

