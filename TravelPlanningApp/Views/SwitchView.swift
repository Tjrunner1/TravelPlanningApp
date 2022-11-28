//
//  SwitchView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/13/22.
//

import SwiftUI

struct SwitchView: View {
    @State var isCalendar: Bool
    @State var identifier: Identifiers? = nil
    
    var body: some View {
        if (isCalendar) {
            CalendarView(identifier: identifier!)
        } else {
            AddTripView(isCalendar: $isCalendar, identifier: $identifier)
        }
    }
}

