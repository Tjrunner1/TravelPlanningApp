//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var TVM: TripsViewModel
//    var identifier: Identifiers
    let dateFormatter = DateFormatter()
    var activity: Activity
    
//    init(identifier: Identifiers) {
//        dateFormatter.dateFormat = "h:mm a";
//        self.identifier = identifier
//    }
    init(activity: Activity) {
        dateFormatter.dateFormat = "h:mm a";
        self.activity = activity
    }
    
    var body: some View {
        VStack{
            Text(activity.title)
                .font(.title)
            Spacer()
            Text("Start Time: \(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(activity.startTime))))")
            Text("End Time: \(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(activity.endTime))))")
            if activity.description != nil {
                Text(activity.description!)
            }
            if activity.url != nil {
                Text(activity.url!)
            }
            if activity.address != nil {
                Text(activity.address!)
            }
            Spacer()
        }
//        VStack{
//            Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].title)
//                .font(.title)
//            Spacer()
//            Text("Start Time: \(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].startTime))))")
//            Text("End Time: \(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].endTime))))")
//            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].description != nil {
//                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].description!)
//            }
//            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].url != nil {
//                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].url!)
//            }
//            if TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].address != nil {
//                Text(TVM.trips[identifier.tripID].days[identifier.dateID!].activities[identifier.activityID!].address!)
//            }
//            Spacer()
//        }
    }
}
