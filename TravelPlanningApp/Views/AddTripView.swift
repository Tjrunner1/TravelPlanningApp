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
    @Binding var selectedTrip: Trip?
    
    
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
                selectedTrip = TVM.addTrip(name: tripName, startDate: 0, endDate: Double(days))
                isCalendar.toggle()
            } label: {
                Text("Create Trip")
                Image(systemName: "plus.circle").font(.title)
            }
            Spacer()
        }
    }
}

//struct AddTripView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTripView(isCalendar: Binding<Bool>false).environmentObject(TripsViewModel())
//    }
//}
