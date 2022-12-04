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
         
            Button{
                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
                TVM.editActivity(activity: activity, title: title, startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents, description: description, url: "https://developer.apple.com/documentation/swift/sequence", address: "https://maps.apple.com/?address=604%20W%20Main%20St,%20Grove%20City,%20PA%20%2016127,%20United%20States&auid=9491263982490320241&ll=41.160939,-80.094114&lsp=9902&q=Pizza%20Joe's&_ext=CjMKBQgEEOIBCgQIBRADCgUIBhC6AgoECAoQAAoECFIQAQoECFUQDQoECFkQAQoFCKQBEAESJimqmnuUB5REQDEJYetFZwZUwDkocKHwLZVEQEH92o7HowVUwFAE")
                
                dismiss()
            } label: {
                Text("Update Activity")
            }
        }
        
    }
}

