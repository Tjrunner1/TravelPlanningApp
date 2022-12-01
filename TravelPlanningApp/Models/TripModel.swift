//
//  TripModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import Foundation

class Trip: Decodable, Identifiable, ObservableObject {
    var id: Int
    @Published var name: String
    @Published var startDate: Double
    @Published var endDate: Double
    @Published var days: [Day]
    
    
    init(id: Int, name: String, startDate: Double, endDate: Double, days: [Day]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.days = days
    }
    
    private enum CodingKeys : String, CodingKey { case id, name, startDate, endDate, days }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.startDate = try container.decode(Double.self, forKey: .startDate)
        self.endDate = try container.decode(Double.self, forKey: .endDate)
        self.days = try container.decode([Day].self, forKey: .days)
    }
}
