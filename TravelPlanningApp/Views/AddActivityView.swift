//
//  AddActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct AddActivityView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Environment(\.dismiss) private var dismiss
    var identifier: Identifiers
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var title: String = ""
    let dateFormatter = DateFormatter()
    
//    init(identifier: Identifiers){
//        identifier=identifier
//        dateFormatter.dateStyle = .medium
//    }
//
    var body: some View {
    
        
        VStack{
            Text("Add an event")
//            Text("\(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(TVM.trips[identifier.tripID].days[identifier.dateID!].date))))")
        
            HStack{
                Text("Event Title")
                TextField("Hike", text: $title)
            }
            
            DatePicker("Start Time", selection: $startTime, displayedComponents: [.hourAndMinute])
            DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute])
            
            Button{
                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from:endTime)
                
                TVM.addActivity(identifier: identifier, title: title, startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents)
                
                dismiss()
            }label:{
                Text("Create activity")
            }
        }
//        Button{
//            let date = Date(timeIntervalSinceNow: TVM.trips[identifier.tripID].days[identifier.dateID!].date)
//            let startDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//            let endDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//
//            TVM.addActivity(identifier: identifier, title: "My Activity", startTimeComponents: startDateComponents, endTimeComponents: endDateComponents)
//        } label: {
//            Text("Click me to add an activity")
//        }
        
       
        
    }
}
