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
//        GeometryReader{ gp in
            ScrollView{
                VStack(alignment: .center){
                    Text(trip.name)
                        .font(.title)
                    CalendarView(trip: trip)//.frame(height: gp.size.height/8 * CGFloat(trip.days.count % 5 + 1))
//                    if ( != nil) {
//                        IndvidualDayView(identifier: $identifier)
//                    }
                    Spacer()
                }
            }
//        }
    }
}
