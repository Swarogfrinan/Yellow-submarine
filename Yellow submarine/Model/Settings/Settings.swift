//
//  Settings.swift
//  submarine
//
//  Created by Ilya Vasilev on 02.02.2022.
//

//import Foundation
//class Settings: Codable {
//
//    var submarine: SubmarineSkin = .gray
//    var name: String
//    var speed = 1
//    var rock = true
//    var fish = false
//
//    init (submarine: SubmarineSkin, name: String, speed: Int, rock: Bool, fish: Bool) {
//
//    self.submarine = submarine
//    self.name = name
//    self.speed = speed
//    self.rock = rock
//    self.fish = fish
//    }
//    private enum CodingKeys: String, CodingKey {
//    case submarine, name, speed, rock, fish
//    }
//    required public init(from decoder: Decoder) throws {
//    let container = try decoder.container (keyedBy: CodingKeys.self)
//
//    self.name = try container.decode(String.self, forKey: .name)
//    self.submarine = try container.decode (SubmarineSkin.self, forKey: .submarine)
//    self.speed = try container.decode(Int.self, forKey: .speed)
//    self.rock = try container.decode(Bool.self, forKey: .rock)
//    self.fish = try container.decode(Bool.self, forKey: .fish)
//    }
//    public func encode(to encoder: Encoder) throws {
//    var container = encoder.container (keyedBy: CodingKeys.self)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.submarine, forKey: .submarine)
//    try container.encode(self.speed, forKey: .speed)
//    try container.encode(self.rock, forKey: .rock)
//    try container.encode(self.fish, forKey: .fish)
