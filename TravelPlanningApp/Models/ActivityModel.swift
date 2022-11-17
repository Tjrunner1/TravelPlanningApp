//
//  ActivityModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import Foundation

struct Activity: Decodable, Identifiable {
    var id: Int
    var title: String
    var startTime: Double
    var endTime: Double
    var description: String?
    var url: String?
    var address: String?
}
