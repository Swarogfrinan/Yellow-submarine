import UIKit

class RecordCell: UITableViewCell {
    
    let records = RecordsData()
    
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        userNicknameLabel.text = "\(String(describing: records.nickname))"
        dateLabel.text = "\(String(describing: records.date))"
        scoreLabel.text = "\(String(describing: records.score))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("Choosed \(String(describing: userNicknameLabel.text)), with \(String(describing: dateLabel.text)) and \(String(describing: scoreLabel.text))")
    }
}


