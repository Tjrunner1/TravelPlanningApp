//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    let dateFormatter = DateFormatter()
    @ObservedObject var activity: Activity
    
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
    }
}
