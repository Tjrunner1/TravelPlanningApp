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
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var days: [Day]
    @Published var list: String = ""
    
    
    init(id: Int, name: String, startDate: Date, endDate: Date, days: [Day], list:String?) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.days = days
        self.list = list ?? ""
    }
    
    private enum CodingKeys : String, CodingKey { case id, name, startDate, endDate, days, list }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.startDate = Date(timeIntervalSinceReferenceDate: try container.decode(Double.self, forKey: .startDate))
        self.endDate = Date(timeIntervalSinceReferenceDate: try container.decode(Double.self, forKey: .endDate))
        self.days = try container.decode([Day].self, forKey: .days)
        self.list = try container.decode(String.self, forKey: .list)
    }
}
