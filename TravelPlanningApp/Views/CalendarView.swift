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
        GeometryReader{ gp in
            VStack{
                TagsView(identifier: $identifier).frame(height: gp.size.height/4)
                Divider()
                IndvidualDayView(identifier: $identifier)
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
                VStack{
                    ForEach(TVM.trips[identifier.tripID].days){day in
                        if identifier.dateID == day.id{
                            ForEach(TVM.trips[identifier.tripID].days[(identifier.dateID!)].activities){activity in
                                NavigationLink{
                                    ActivityView()
                                } label: {
                                    ZStack{
                                        Rectangle().cornerRadius(20).foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.896)).shadow(radius: 5).frame( height: 100)
                                        Text("\(activity.title)").foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            NavigationLink{
                AddActivityView(identifier: $identifier)
            } label: {
                Image(systemName: "plus.circle").font(.title).frame(alignment: .center)
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
        VStack{
            GeometryReader { gp in
                    HStack{
                        ForEach(TVM.trips[identifier.tripID].days) { day in
                            Button{
                                identifier.dateID = day.id
                            } label: {
                                ZStack{
                                    Rectangle().foregroundColor(Color(hue: 0.572, saturation: 0.635, brightness: 0.672))
                                    Text(String(format: "%02d", day.id+1)).foregroundColor(.white)
                                }.frame(width: gp.size.width/6, height: gp.size.height/2)
                            }
                        }
                    }
            }
        }
    }
}

