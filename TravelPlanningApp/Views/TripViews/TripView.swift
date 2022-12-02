//
//  TripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/28/22.
//

import SwiftUI

struct TripView: View {
    @ObservedObject var trip: Trip
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Text(trip.name)
                    .font(.title)
                CalendarView(trip: trip)
                Spacer()
            }
        }
    }
}
