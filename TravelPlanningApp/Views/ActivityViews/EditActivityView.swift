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
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        VStack{
            Text("HI there")
            Button{
//                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
//                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
//                TVM.editActivity(activity: activity, title: "New Placeholder title", startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents, description: "description", url: "https://developer.apple.com/documentation/swift/sequence", address: "https://maps.apple.com/?address=604%20W%20Main%20St,%20Grove%20City,%20PA%20%2016127,%20United%20States&auid=9491263982490320241&ll=41.160939,-80.094114&lsp=9902&q=Pizza%20Joe's&_ext=CjMKBQgEEOIBCgQIBRADCgUIBhC6AgoECAoQAAoECFIQAQoECFUQDQoECFkQAQoFCKQBEAESJimqmnuUB5REQDEJYetFZwZUwDkocKHwLZVEQEH92o7HowVUwFAE")
                
                dismiss()
            } label: {
                Text("Update Activity")
            }
        }
        
    }
}

