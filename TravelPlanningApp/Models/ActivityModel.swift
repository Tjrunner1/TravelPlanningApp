//
//  ActivityModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import Foundation

class Activity: Decodable, Identifiable, ObservableObject {
    var id: Int
    @Published var title: String
    @Published var startTime: Double
    @Published var endTime: Double
    @Published var description: String?
    @Published var url: String?
    @Published var address: String?
    
    init(id: Int, title: String, startTime: Double, endTime: Double, description: String = "", url: String = "", address: String = "") {
        self.id = id
        self.title = title
        self.startTime = 0
        self.endTime = 0
        self.description = description
        self.url = url
        self.address = address
    }
    
    
    private enum CodingKeys : String, CodingKey { case id, title, startTime, endTime, description, url, address }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.startTime = try container.decode(Double.self, forKey: .startTime)
        self.endTime = try container.decode(Double.self, forKey: .endTime)
        self.description = try container.decode(String.self, forKey: .description)
        self.url = try container.decode(String.self, forKey: .url)
        self.address = try container.decode(String.self, forKey: .address)
    }
}
