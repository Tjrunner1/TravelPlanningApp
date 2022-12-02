//
//  DayModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import Foundation
import SwiftUI

class Day: Decodable, Identifiable, ObservableObject {
    var id: Int
    @Published var date: Date
    @Published var activities: [Activity]
    
    init(id: Int, date: Date, activities: [Activity]) {
        self.id = id
        self.date = date
        self.activities = activities
    }
    
    
    private enum CodingKeys : String, CodingKey { case id, date, activities }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = Date(timeIntervalSinceReferenceDate: try container.decode(Double.self, forKey: .date))
        self.activities = try container.decode([Activity].self, forKey: .activities)
    }
}

