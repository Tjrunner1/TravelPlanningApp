//
//  Tabs.swift
//  TravelPlanningApp
//
//  Created by Tori Keener on 12/6/22.
//

import SwiftUI

struct Tabs: View {
    @ObservedObject var trip: Trip
    var dayID: Int = 0

    var body: some View {
        TabView{
            TripView(trip: trip, dayID: dayID)
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
            ListView(trip: trip)
                .tabItem{
                    Label("Packing List", systemImage: "note")
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
