//
//  DayModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import Foundation

struct Day: Decodable, Identifiable {
    var id: Int
    var activities: [Activity]
}
