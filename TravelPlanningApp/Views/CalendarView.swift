//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var TVM: TripsViewModel
    
    var body: some View {
        Text("CalendarView")
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
