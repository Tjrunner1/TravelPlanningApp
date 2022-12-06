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
                        ContainerView(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.896))
                        VStack{
                            Text("\(activity.title)").foregroundColor(.black).font(.title).frame(alignment: .leading)
                            Text("\(activity.startTime.formatted(date: .omitted, time: .shortened)) - \(activity.endTime.formatted(date: .omitted, time: .shortened))").foregroundColor(.black).font(.subheadline)
                        }
                    }
                }
            }
            NavigationLink{
                CreateActivityView(day: day)
            } label: {
                VStack{
                    AddButtonView(color: Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                    Text("Add Activity").font(.system(.headline, design: .rounded))
                        .foregroundColor((Color(hue: 0.572, saturation: 0.792, brightness: 0.594)))
                }
            }
        }
    }
}
