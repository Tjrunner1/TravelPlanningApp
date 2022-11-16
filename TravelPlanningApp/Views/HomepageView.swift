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
                                Rectangle().cornerRadius(20).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.896)).shadow(radius: 5).frame( height: 100)
                                Text("\(trip.name)").foregroundColor(.black)
                                    
                            }
                        }
                    }
                    NavigationLink{
                        SwitchView(isCalendar: false)
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .foregroundColor(Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding()
                    }
                }
            }.navigationTitle("My Trips")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(hue: 0.302, saturation: 0.184, brightness: 0.695))
        }
    }
}

struct SelectTripView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView().environmentObject(TripsViewModel())
    }
}
