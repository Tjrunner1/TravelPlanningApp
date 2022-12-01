//
//  SelectTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var TVM: TripsViewModel

    init() {
        //check to see if alternate view should be loaded (aka. if the date overlaps with a trip)
        findApplicableTrip()
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(hue: 0.302, saturation: 0.184, brightness: 0.695).ignoresSafeArea()
                ScrollView{
                    VStack{
                        ForEach(TVM.trips) { trip in
                            TripContainerView(trip: trip)
                        }
                        NavigationLink{
                            CreateTripView()
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundColor(Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50, alignment: .center)
                                .padding()
                        }
                    }
                }
            }.navigationTitle("My Trips").navigationBarTitleDisplayMode(.inline)
        }
    }
}

func findApplicableTrip() {
    
}
