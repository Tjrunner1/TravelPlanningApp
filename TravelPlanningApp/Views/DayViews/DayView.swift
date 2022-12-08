//
//  DayView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/28/22.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var day: Day
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height

    var body: some View{
        VStack{
            ForEach(day.activities){ activity in
                NavigationLink {
                    ActivityView(day: day, activity: activity)
                } label: {
                    ZStack{
                        ContainerView(color: Color(hue: 0.084, saturation: 0.120, brightness: 0.821))
                       // ContainerView(color: Color(hue: 0.261, saturation: 0.075, brightness: 0.71))
                        VStack{
                            Text("\(activity.title)").foregroundColor(.white).font(.title).frame(alignment: .leading)
                            Text("\(activity.startTime.formatted(date: .omitted, time: .shortened)) - \(activity.endTime.formatted(date: .omitted, time: .shortened))").foregroundColor(.white).font(.subheadline)
                        }
                    }
                }
            }
            NavigationLink{
                CreateActivityView(day: day)
            } label: {
                VStack{
                    AddButtonView(color: Color(hue: 0.572, saturation: 0.137, brightness: 0.679))
                    Text("Add Activity").font(.system(.headline, design: .rounded))
                        .foregroundColor((Color(hue: 0.572, saturation: 0.137, brightness: 0.679)))
                }
            }
        }
    }
}
