//
//  TripContainerView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/28/22.
//

import SwiftUI

struct TripContainerView: View {
    @ObservedObject var trip: Trip
    
    var body: some View {
        NavigationLink{
            TripView(trip: trip)
        } label: {
            ZStack{
                Rectangle().cornerRadius(20).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.896)).shadow(radius: 5).frame( height: 100)
                    .padding(7)
                Text("\(trip.name)").foregroundColor(.black)
            }
        }
    }
}
