//
//  RecordTableViewCell.swift
//  submarine
//
//  Created by Ilya Vasilev on 30.03.2022.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
        
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
override func awakeFromNib() {
    super.awakeFromNib()

}
    func configure(records: Record) {
        dateLabel.text = records.date
        scoreLabel.text = "\(String(describing: records.score))"
    }
override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
}
}


