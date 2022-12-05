//
//  DayView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/28/22.
//

import SwiftUI

struct DayView: View {
    @ObservedObject var day: Day

    var body: some View{
        VStack{
            ForEach(day.activities){ activity in
                NavigationLink {
                    ActivityView(activity: activity)
                } label: {
                    ZStack{
                        ContainerView(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.896))
                        Text("\(activity.title)").foregroundColor(.black)
                    }
                }
            }
            NavigationLink{
                CreateActivityView(day: day)
            } label: {
                VStack{
                    AddButtonView(color: Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                    Text("Add Activity")
                        .foregroundColor((Color(hue: 0.572, saturation: 0.792, brightness: 0.594)))
                }
            }
        }
    }
}
