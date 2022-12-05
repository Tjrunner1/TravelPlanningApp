//
//  EditTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/4/22.
//

import SwiftUI

struct EditTripView: View {
    var width = UIScreen.main.bounds.width

    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var trip: Trip
    
    @State var name:String
    @State var startDate: Date
    @State var endDate: Date
    
    var body: some View {
        
        VStack{
            TextField(trip.name, text: $name).frame(width: width/4, alignment: .center).font(.system(.title, design: .rounded))
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
            
            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
              
            
            Button{
                TVM.editTrip(trip: trip, name: name, startDate: startDate, endDate: endDate)
            } label: {
                Text("Update Trip")
            }
            Spacer()
        }
    }
}
