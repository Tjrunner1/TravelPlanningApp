//
//  AddActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct AddActivityView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers?
    
    var body: some View {
        Button{
            let date = Date(timeIntervalSinceNow: TVM.trips[identifier!.tripID].days[identifier!.dateID!].date)
            let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            
            TVM.addActivity(identifier: identifier!, title: "My Activity", startTimeComponents: startDateComponents, endTimeComponents: endDateComponents)
        } label: {
            Text("Click me to add an activity")
        }
    }
}
