//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers
    
    var body: some View {
        VStack{
            Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].title)
            Text("Start Time: \(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].startTime)")
            Text("End Time: \(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].endTime)")
            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].description != nil {
                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].description!)
            }
            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].url != nil {
                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].url!)
            }
            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].address != nil {
                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].address!)
            }
        }
    }
}
