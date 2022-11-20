//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI


struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @State var identifier: Identifiers
    
    var body: some View {
        Text(TVM.trips[identifier.tripID].name)
            .font(.title)
        GeometryReader{ gp in
            VStack(alignment: .center){
                TagsView(identifier: $identifier).frame(height: gp.size.height/4)
                Divider()
                if (identifier.dateID != nil) {
                    IndvidualDayView(identifier: $identifier)
                }
                Spacer()
            }
        }
    }
}

struct IndvidualDayView: View{
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers
    
    var body: some View{
        VStack{
            if(identifier.dateID != nil){
                Text("Activities")
                    .font(.title)
                VStack{
                    ForEach(TVM.trips[identifier.tripID].days){day in
                        if identifier.dateID == day.id{
                            ForEach(TVM.trips[identifier.tripID].days[(identifier.dateID!)].activities){activity in
                                NavigationLink {
                                    let activityIdentifer = Identifiers(tripID: identifier.tripID, dateID: identifier.dateID!, activityID: activity.id)
                                    ActivityView(identifier: activityIdentifer)
                                } label: {
                                    ZStack{
                                        Rectangle().cornerRadius(20).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.896)).shadow(radius: 5).frame(height: 100)
                                            .padding(7)
                                        Text("\(activity.title)").foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            NavigationLink{
                let dayIdentifier = Identifiers(tripID: identifier.tripID, dateID: identifier.dateID!)
                AddActivityView(identifier: dayIdentifier)
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .foregroundColor(Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding()
            }
        }
    }
}

struct TagsView: View{
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers
    
    init(identifier: Binding<Identifiers>){
        self._identifier = identifier
    }
    
    var body: some View{
        GeometryReader { gp in
            VStack{
                ForEach(0...Int(TVM.trips[identifier.tripID].days.count/5), id: \.self) { i in
                    HStack{
                        ForEach(createArrayOfDaysDisplay(i: i)) { day in
                            Button{
                                identifier.dateID = day.id
                            } label: {
                                ZStack{
                                    Rectangle().foregroundColor(Color(hue: 0.572, saturation: 0.635, brightness: 0.672))
                                        .cornerRadius(10)
                                    Text(String(format: "%02d", day.id+1)).foregroundColor(.white)
                                }.frame(width: gp.size.width/6, height: gp.size.height/2)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createArrayOfDaysDisplay(i: Int) -> [Day] {
        let numberOfItemsPerRow = 5
        var returnArray: [Day] = []
        
        for day in TVM.trips[identifier.tripID].days {
            if day.id < numberOfItemsPerRow * (i+1) && day.id >= numberOfItemsPerRow * (i+1) - numberOfItemsPerRow {
                returnArray.append(day)
            }
        }
        
        return returnArray
    }
}

