//
//  AddTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @State var trip: Trip?
    @State var tripName: String = "";
    @State var days: Int = 1
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View {
        if (trip == nil) {
            VStack{
                Text("Create a Trip")
                    .font(.title)
                HStack(){
                    Text("Trip Name:        ")
                    TextField("Rome 2023", text: $tripName)
                        .textFieldStyle(.roundedBorder)
                }.frame(width: width/1.3, alignment: .leading)
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                    .frame(width: width/1.3, alignment: .leading)
                DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                    .frame(width: width/1.3, alignment: .leading)
                //Spacer()
                Button {
                    if endDate < startDate {
                        endDate = startDate
                    }
                    
                    self.trip = TVM.createTrip(name: tripName, startDate: startDate, endDate: endDate)
                } label: {
                    ZStack{
                        Rectangle().fill(Color(hue: 0.572, saturation: 0.792, brightness: 0.594)).cornerRadius(12).padding()
                            .frame(height: height/10)
                        Text("Create Trip")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
        } else {
            //TripView(trip: trip!)
            Tabs(trip: trip!)
        }
    }
}

