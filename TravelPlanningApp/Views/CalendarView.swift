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
        Text("\(selectedTrip?.name ?? "")")
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
