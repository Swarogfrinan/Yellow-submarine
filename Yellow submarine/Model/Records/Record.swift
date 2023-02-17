//
//  result.swift
//  submarine
//
//  Created by Ilya Vasilev on 27.04.2022.
//

import Foundation

class Record: Codable {
    var score: Int?
    var date: String?
    
    init(score: Int?, date: String?) {
        self.score = score
        self.date = date
    }
    
     enum CodingKeys: String, CodingKey {
        case scoreKey
        case dateKey
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        score = try container.decodeIfPresent(Int.self, forKey: .scoreKey)
        date = try container.decodeIfPresent(String.self, forKey: .dateKey)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.score, forKey: .scoreKey)
        try container.encode(self.date, forKey: .dateKey)
    }
}
