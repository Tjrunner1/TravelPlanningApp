//
//  AddActivityView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CreateActivityView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var day: Day
    
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var title: String = ""
    @State private var description = ""
    @State private var url = ""
    @State private var address = ""

    var body: some View {
        ScrollView{
        VStack{
            Text("\(applyDateFormat(timeStamp: day.date))")
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
            HStack{
                Text("Url:                       ")
                TextField("https://www.google.com",text: $url)
                    .border(.gray)
                    .frame(height: 200)
            }.frame(width: 250, alignment: .center)
            HStack{
                Text("Address:                       ")
                TextEditor(text: $address)
                    .border(.gray)
                    .frame(height: 200)
            }.frame(width: 250, alignment: .center)
            Spacer()
            Button{
                let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                
                TVM.createActivity(day: day, title: title, startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents, description: description, url: url, address: address)
                
                dismiss()
            }label:{
                ZStack{
                    Text("Create activity")
                        .padding()
                        .border(.blue)
                }
                
            }.padding()
        }
        }
    }
    
    func applyDateFormat(timeStamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let timeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        
        return dateFormatter.string(from: date)
    }
}
