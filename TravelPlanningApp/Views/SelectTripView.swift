//
//  SelectTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct SelectTripView: View {
    
    
    init() {
        //check to see if alternate view should be loaded (aka. if the date overlaps with a trip)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Hi there!")
                Text("Add a trip plan or select a prexisiting plan to get started")
//                ForEach(vacationPlanThing) {
//                    ZStack{
//                            RoundedRectangle()
//                    }
//                }
                NavigationLink{
                    CalendarView()//will need to pass the vacation
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
        
    }
}

struct SelectTripView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTripView()
    }
}
