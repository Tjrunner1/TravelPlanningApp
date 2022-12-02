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
            VStack(){
                Text("\(applyDateFormat(date: day.date))")
                    .font(.title)
                Spacer()
            
                VStack(alignment:.leading, spacing: 0){
                    Text("Event Title:                 ")
                    TextField("", text: $title)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: 250, alignment: .center)
                
                
                    DatePicker("Start Time:", selection: $startTime, displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .leading)
                DatePicker("End Time:", selection: $endTime, in: startTime... , displayedComponents: [.hourAndMinute])
                    .frame(width: 250, alignment: .center)
                VStack(alignment: .leading, spacing: 0){
                    Text("Notes:                       ")
                    TextEditor(text: $description)
                        .border(.gray)
                        .frame(height: 75)
                }.frame(width: 250, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("URL:                       ")
                    TextField("https://www.google.com",text: $url)
                        .textFieldStyle(.roundedBorder)
                        .border(.gray)
                }.frame(width: 250, alignment: .center)
                VStack(alignment:.leading, spacing: 0){
                    Text("Address:                       ")
                    TextEditor(text: $address)
                        .border(.gray)
                        .frame(height: 75)
                }.frame(width: 250, alignment: .center)
              
                Button{
                    let startTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                    let endTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                    
                    TVM.createActivity(day: day, title: title, startTimeComponents: startTimeComponents, endTimeComponents: endTimeComponents, description: description, url: url, address: address)
                    
                    dismiss()
                }label:{
                    ZStack{
                        Rectangle().fill(Color(hue: 0.294, saturation: 0.31, brightness: 0.661))
                            .cornerRadius(12)
                        Text("Create activity")
                            .foregroundColor(.white)
                            .padding()
                            
                    }.padding()
                    
                }.padding()
            }
        }
    }
    
    func applyDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
}
