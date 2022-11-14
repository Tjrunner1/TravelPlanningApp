//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var selectedTrip: Trip?
    
    var body: some View {
    //    GeometryReader{gp in
            Text("\(selectedTrip?.name ?? "")")
        VStack{
                HStack{
                    ForEach(0..<(selectedTrip?.days.count)!, id: \.self){day in
                        ZStack{
                            Rectangle().frame(width: 20, height: 20, alignment: .leading).foregroundColor(.gray)
                            Text("\(day + 1)")
                        }
                }
            }
        }
       // }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}

//for every 7 days
//create new Hstack

//for i in selectedtrip.days where i % 7 == 0
