import UIKit

class RecordsViewController: UIViewController {
    
    //MARK: Constant
    
    var manager = RecordsManager()
    
    //MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.loadGameResults()
        setupDelegate()
    }
    
    
    //MARK:  Methods
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
//MARK: UITableViewDataSource
extension RecordsViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }
        if let recordDate = manager.records[indexPath.row].date {
            print("Запись даты последнего рекорда \(recordDate)")
            cell.dateLabel.text = "\(recordDate)"
        }
        //        if let recordScore = manager.records.sorted(by: {$0.score > $1.score })[indexPath.row].score {
        let recordScore = manager.records[indexPath.row].score
        //        if recordScore != nil {
        print("Запись счёта последнего рекорда \(String(describing: recordScore))")
        cell.scoreLabel.text = recordScore.description
        cell.userNicknameLabel.text = "Nickname"
        //        }
        
        return cell
    }
}

//MARK: UITableViewDelegate

extension RecordsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}

