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
    
    //These need a home and added to the view for start and end date
    let day = 14
    let month = 6
    let year = 2023
    
    
    var body: some View {
        let daysString = Binding<String>(
            get : {
                String(self.days)
            },
            set : {
                if let value = NumberFormatter().number(from: $0) {
                    //when input is a valid number
                    self.days = value.intValue
                }
            }
        )

        VStack{
            Text("Create a Trip")
                .font(.title)
            HStack{
                Text("Trip Name: ")
                TextField("Rome 2023", text: $tripName)
            }.padding(10)
            HStack{
                Text("Number of days:")
                TextField("5", text: daysString)
            }.padding(10)
            Spacer(minLength: 2)
            Button {
                let startDateComponents = DateComponents(year: year, month: month, day: day)
                let endDateComponents = DateComponents(year: year, month: month, day: day)
                
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

