//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @Binding var identifier: Identifiers?
    
    var body: some View {
    //    GeometryReader{gp in
            Text("\(selectedTrip?.name ?? "")")
        VStack{
            Text("\(TVM.trips[identifier!.tripID].name)")
            Button{
                //do the thing
                let startDateComponents = DateComponents(year: 2023, month: 12, day: 2)
                let endDateComponents = DateComponents(year: 2023, month: 12, day: 2)
                
                let test = Identifiers(tripID: identifier!.tripID, dateID: 0)
                TVM.addActivity(identifier: test, title: "thing 1", startTimeComponents: startDateComponents, endTimeComponents: endDateComponents)
            } label: {
                Text("test the thing")
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
