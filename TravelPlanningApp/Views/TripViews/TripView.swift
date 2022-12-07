//
//  TripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/28/22.
//

import SwiftUI

struct TripView: View {
    @ObservedObject var trip: Trip
    var dayID: Int = 0
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Text(trip.name)
                    .font(.title)
                CalendarView(trip: trip, day: trip.days[dayID])
                Spacer()
            }
        }.toolbar{ToolbarItem{
            NavigationLink{
                EditTripView(trip: trip, name: trip.name, startDate: trip.startDate, endDate: trip.endDate)
            } label: {
                Image(systemName: "pencil")
            }
        }}
    }
}
