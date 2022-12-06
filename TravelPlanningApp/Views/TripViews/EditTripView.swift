//
//  EditTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 12/4/22.
//

import SwiftUI

struct EditTripView: View {
    @Environment(\.dismiss) private var dismiss
    var width = UIScreen.main.bounds.width

    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var trip: Trip
    
    @State var name:String
    @State var startDate: Date
    @State var endDate: Date
    
    var body: some View {
        
        VStack{
            TextField(trip.name, text: $name).frame(width: width/4, alignment: .center).font(.system(.title, design: .rounded))
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
            
            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
              
            Button{
                TVM.deleteTrip(trip: trip)
                
                //There is no good way to do this, without updating to a newer version of Xcode
                guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
                navigationController.popToRootViewController(animated: true)
            } label: {
                Text("Delete the Trip")
            }
            Button{
                TVM.editTrip(trip: trip, name: name, startDate: startDate, endDate: endDate)
                dismiss()
            } label: {
                Text("Update Trip")
            }
            Spacer()
        }
    }
}
