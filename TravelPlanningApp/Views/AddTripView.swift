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
    
    
    var body: some View {
        Text("add trip view")
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
            HStack{
                Text("Trip Name: ")
                TextField("Camping Trip", text: $tripName)
            }
            HStack{
                Text("Number of days:")
                TextField("5", text: daysString)
            }
            Button{
                TVM.addTrip(name: tripName, startDate: 0, endDate: Double(days))
                isCalendar.toggle()
            } label: {
                Label("Create trip", systemImage: "plus.circle")
            }
        }
    
       
    }
}

//struct AddTripView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTripView(isCalendar: Binding<Bool>false).environmentObject(TripsViewModel())
//    }
//}
