//
//  TripModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import Foundation

struct Trip: Decodable, Identifiable {
    var id: Int
    var name: String
}
