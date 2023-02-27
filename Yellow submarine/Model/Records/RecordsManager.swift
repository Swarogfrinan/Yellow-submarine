import Foundation

enum RecordsKeys: String {
    case recordsKey
}

class RecordsManager {
    
    var recordsList = [Record]() {
        didSet {
            let records = UserDefaults.standard.value(forKey: RecordsKeys.recordsKey.rawValue)
            
        }
    }
    
    static let shared = RecordsManager()
    
    func saveRecords(_ records: Record) {
        var array = self.loadRecords()
        array.append(records)
        UserDefaults.standard.set(array, forKey: RecordsKeys.recordsKey.rawValue)
    }
    
    func loadRecords() -> [Record] {
        guard let records = UserDefaults.standard.value(forKey: RecordsKeys.recordsKey.rawValue) else {
            fatalError("Cannot loadRecords")
        }
        return recordsList
    }
}
