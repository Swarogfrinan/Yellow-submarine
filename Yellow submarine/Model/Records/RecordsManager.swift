//
//  RecordsManager.swift
//  submarine
//
//  Created by Ilya Vasilev on 29.04.2022.
//

import Foundation

enum RecordsKeys: String {
    case recordsKey
}

class RecordsManager {
    
    static let shared = RecordsManager()
    
    func saveRecords(_ records: Record) {
        
        var array = self.loadRecords()
        array.append(records)
        UserDefaults.standard.set(encodable: array, forKey: RecordsKeys.recordsKey.rawValue)
        
    }
    
    func loadRecords() -> [Record] {
        guard let records = UserDefaults.standard.value([Record].self, forKey: RecordsKeys.recordsKey.rawValue) else {
            return []
        }
        return records
    }
//    static func lauchSubmarinePlay 
}
