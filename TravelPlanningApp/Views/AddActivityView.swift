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
    @State private var description = ""
    
    
    init(identifier: Identifiers){
        self.identifier = identifier
        dateFormatter.dateStyle = .medium
    }

    var body: some View {
    
        
        
        VStack{
            Text("\(dateFormatter.string(from: Date(timeIntervalSinceReferenceDate:  TimeInterval(TVM.trips[identifier.tripID].days[identifier.dateID!].date))))")
                .font(.title)
            Spacer()
        
            HStack{
                Text("Event Title:                 ")
                TextField("", text: $title)
                    .textFieldStyle(.roundedBorder)
            }.frame(width: 250, alignment: .center)
            
            DatePicker("Start Time:", selection: $startTime, displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .leading)
            DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                .frame(width: 250, alignment: .center)
            HStack{
                Text("Notes:                       ")
                TextEditor(text: $description)
                    .border(.gray)
                    .frame(height: 200)
            }.frame(width: 250, alignment: .center)
            Spacer()
            Button{
                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
                TVM.addActivity(identifier: identifier, title: title, startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents, description: description)
                
                dismiss()
            }label:{
                ZStack{
                    Text("Create activity")
                        .padding()
                        .border(.blue)
                }
                
            }.padding()
            Spacer()
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
