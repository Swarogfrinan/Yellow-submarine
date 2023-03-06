import Foundation

//enum RecordsKeys: String {
//    case recordsKey
//}

class RecordsManager {
    static let shared = RecordsManager()
    
    var recordsList = [Record]() {
        didSet {
            UserDefaults.standard.set(recordsList, forKey: "recordsList")
        }
    }

    func saveRecords(_ records: Record) {
        var array = self.loadRecords()
        array.append(records)
        UserDefaults.standard.set(array, forKey: "recordsList") 
    }
    
    func loadRecords() -> [Record] {
        guard let records = UserDefaults.standard.value(forKey: "recordsList") as? [Record] else {
            fatalError("Cannot loadRecords")
        }
        return records
    }
}
