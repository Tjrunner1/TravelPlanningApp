//
//  AddTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @State var tripID: Int?
    @State var tripName: String = "";
    @State var days: Int = 1
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    
    var body: some View {
        if (tripID == nil) {
            VStack{
                Text("Create a Trip")
                    .font(.title)
                HStack(){
                    Text("Trip Name:        ")
                    TextField("Rome 2023", text: $tripName)
                        .textFieldStyle(.roundedBorder)
                }.frame(width: 250, alignment: .leading)
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    .frame(width: 250, alignment: .leading)
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                    .frame(width: 250, alignment: .leading)
                Spacer(minLength: 2)
                Button {
                    let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
                    let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: endDate)
                    
                    self.tripID = TVM.createTrip(name: tripName, startDateComponents: startDateComponents, endDateComponents: endDateComponents)
                } label: {
                    Text("Create Trip")
                    Image(systemName: "plus.circle").font(.title)
                }
                Spacer()
            }
        } else {
            TripView(trip: TVM.trips[tripID!])
        }
    }
}

