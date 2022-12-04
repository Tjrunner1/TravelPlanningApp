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
//                Text("Activities")
//                    .font(.title)
                VStack{
                    ForEach(day.activities){ activity in
                        NavigationLink {
                            ActivityView(activity: activity).toolbar{ToolbarItem{
                                NavigationLink{
                                    EditActivityView(activity: activity, title: activity.title, startTime: activity.startTime, endTime: activity.endTime, description: activity.description ?? "")
                                } label: {
                                    Image(systemName: "pencil")
                                }
                            }}
                        } label: {
                            ZStack{
                                Rectangle().cornerRadius(20).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.896)).shadow(radius: 5).frame(height: 100)
                                    .padding(7)
                                Text("\(activity.title)").foregroundColor(.black)
                        }
                    }
                }
                }

            NavigationLink{
                CreateActivityView(day: day)
            } label: {
                VStack{
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundColor(Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(.top)
                    Text("Add Activity")
                        .foregroundColor((Color(hue: 0.572, saturation: 0.792, brightness: 0.594)))
                }
            }
        }
    }
}

