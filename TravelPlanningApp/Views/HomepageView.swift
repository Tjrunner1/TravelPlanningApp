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
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(TVM.trips) { trip in
                        NavigationLink{
                            let identifier = Identifiers(tripID: trip.id)
                            SwitchView(isCalendar: true, identifier: identifier)
                        } label: {
                            ZStack{
                                Rectangle().cornerRadius(20).foregroundColor(.white).shadow(radius: 5).frame(height: 100)
                                Text("\(trip.name)").foregroundColor(.black)
                            }
                        }
                    }
                    NavigationLink{
                        SwitchView(isCalendar: false)
                    } label: {
                        Image(systemName: "plus.circle").font(.title)
                    }
                }
            }.navigationTitle("My Trips")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SelectTripView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView().environmentObject(TripsViewModel())
    }
}
