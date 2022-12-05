//
//  EditActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/3/22.
//

import SwiftUI

struct EditActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var activity: Activity
    
    @State var title: String
    @State var startTime: Date
    @State var endTime: Date
    @State var description: String
    @State var url: String
    @State var address: String

    
    var body: some View {
        VStack{
            //TITLE
            TextField(activity.title, text: $title)
                .padding()
            
            //STARTTIME
            DatePicker("Start Time", selection: $startTime, displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .leading)
            //ENDTIME
            DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .center)
            //DESCRIPTION
            TextField(description, text: $description)
            
            //URL
            TextField(url, text: $url)
            
            //ADDRESS
            TextField(address, text: $address)
         
            Button{
                //let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                //let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
                TVM.editActivity(activity: activity, title: title, startTime: startTime, endTime: endTime, description: description, url: url, address: address)
                
                dismiss()
            } label: {
                Text("Update Activity")
            }
        }
        
    }
}

