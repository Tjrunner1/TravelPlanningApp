//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activity: Activity
    
    var body: some View {
        VStack{
            Text(activity.title)
                .font(.title)
            Spacer()
            Text("Start Time: \(applyDateFormat(timeStamp: activity.startTime))")
            Text("End Time: \(applyDateFormat(timeStamp: activity.endTime))")
            if activity.description != nil {
                HStack{
                    Text("Description: ")
                    Text(activity.description!)
                }
            }
            if activity.url != nil {
                HStack{
                    Text("Link: ")
                    Link(activity.url!, destination: URL(string: activity.url!)!)
                }
            }
            if activity.address != nil {
                HStack{
                    Text("Address: ")
                    Link("Open In Maps", destination: URL(string: activity.address!)!)
                }
            }
            Spacer()
        }
    }
    
    func applyDateFormat(timeStamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        let timeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)

        return dateFormatter.string(from: date)
    }
}
