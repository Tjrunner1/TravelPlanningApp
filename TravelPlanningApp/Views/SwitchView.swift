//
//  SwitchView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/13/22.
//

import SwiftUI

struct SwitchView: View {
    @State var isCalendar: Bool
    var selectedTrip: Trip?
    
    var body: some View {
        if (isCalendar) {
            CalendarView(selectedTrip: selectedTrip)
        } else {
            AddTripView(isCalendar: $isCalendar)
        }
    }
}

//struct SwitchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwitchView(isCalendar: false)
//    }
//}
