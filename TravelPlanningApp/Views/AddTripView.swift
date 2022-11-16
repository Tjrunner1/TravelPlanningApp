//
//  AddTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import SwiftUI

struct AddTripView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @State var tripName: String = "";
    @State var days: Int = 1
    @Binding var isCalendar: Bool
    @Binding var identifier: Identifiers?
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    //These need a home and added to the view for start and end date
    let day = 14
    let month = 6
    let year = 2023
    
    
    var body: some View {
        VStack{
            Text("Create a Trip")
                .font(.title)
            HStack{
                Text("Trip Name: ")
                TextField("Rome 2023", text: $tripName)
            }.padding(10)
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .frame(width: 250, alignment: .leading)
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                .frame(width: 250, alignment: .leading)
            Spacer(minLength: 2)
            Button {
                let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: startDate)
                let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from:endDate)
                
                identifier = TVM.addTrip(name: tripName, startDateComponents: startDateComponents, endDateComponents: endDateComponents)
                isCalendar.toggle()
            } label: {
                Text("Create Trip")
                Image(systemName: "plus.circle").font(.title)
            }
            Spacer()
        }
    }
}

