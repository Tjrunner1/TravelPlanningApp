//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    var selectedTrip: Trip?
    
    var body: some View {
    //    GeometryReader{gp in
            Text("\(selectedTrip?.name ?? "")")
            HStack{
                ForEach(0..<(selectedTrip?.days.count)!, id: \.self){day in
                    ZStack{
                        Rectangle().frame(width: 50, height: 50, alignment: .leading).foregroundColor(.gray)
                        Text("\(day + 1)")
                        
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
