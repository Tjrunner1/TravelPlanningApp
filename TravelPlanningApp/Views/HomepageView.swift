//
//  SelectTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct HomepageView: View {
    @EnvironmentObject var TVM: TripsViewModel
    var width = UIScreen.main.bounds.width
    
    init() {
        //check to see if alternate view should be loaded (aka. if the date overlaps with a trip)
        findApplicableTrip()
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    VStack{
                        ForEach(TVM.trips) { trip in
                            NavigationLink{
                                TripView(trip: trip)
                            } label: {
                                ZStack{
                                    ContainerView(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.896))
                                    Text("\(trip.name)").foregroundColor(.black)
                                }
                            }
                        }
                        NavigationLink{
                            CreateTripView()
                        } label: {
                            AddButtonView(color: Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                        }.frame(width: width)
                    }
                }
            }.navigationTitle("My Trips")
                .navigationBarTitleDisplayMode(.inline)
                .background(alignment: .center, content:{
                    Image("road").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.65)
                })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

func findApplicableTrip() {
    
}
