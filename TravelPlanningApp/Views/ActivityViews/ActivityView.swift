//
//  ActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activity: Activity
    @EnvironmentObject var TVM: TripsViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(activity.title)
                .font(.title)
                .frame(alignment: .center)
                .padding()
            Text("\(applyDateFormat(date:activity.startTime)) - \(applyDateFormat(date:activity.endTime))").padding()
            Divider().padding(.horizontal)
            if activity.description != nil {
                HStack(){
                    Image(systemName: "note")
                    Text("Notes: ")
                    Text(activity.description!)
                }.padding()
                Divider().padding(.horizontal)
            }
            if activity.url != nil {
                HStack{
                    Image(systemName: "link")
                    Text("Link: ").frame(alignment: .leading)
                    Link(activity.url!, destination: URL(string: activity.url!)!)
                }.padding()
                Divider().padding(.horizontal)
            }
            if activity.address != nil {
                HStack{
                    Image(systemName: "map")
                    Text("Address: ")
                    Link(activity.address!, destination: URL(string: activity.address!)!)
                }.padding()
            }
         Spacer()
            Button(action:{
                TVM.deleteActivity(activity: activity)
            }, label:{
                ZStack{
                    Rectangle().fill(Color(hue: 1, saturation: 0.37, brightness: 0.85)).cornerRadius(12).padding()
                        .frame(height: 100)
                    Text("Delete Activity")
                        .foregroundColor(.white)
                }
            }).padding()
            
        }
    }
    
    func applyDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

//        let timeInterval = TimeInterval(timeStamp)
//        let date = Date(timeIntervalSinceReferenceDate: timeInterval)

        return dateFormatter.string(from: date)
    }
}
