//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers?
    
    var body: some View {
        VStack{
            Text("\(TVM.trips[identifier!.tripID].name)")
            Button{
                //do the thing
                let startDateComponents = DateComponents(year: 2023, month: 12, day: 2)
                let endDateComponents = DateComponents(year: 2023, month: 12, day: 2)
                
                let test = Identifiers(tripID: identifier!.tripID, dateID: 0)
                TVM.addActivity(identifier: test, title: "thing 1", startTimeComponents: startDateComponents, endTimeComponents: endDateComponents)
            } label: {
                Text("test the thing")
            }
        }
    }
}

