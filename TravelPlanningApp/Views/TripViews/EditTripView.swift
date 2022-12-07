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
    var height = UIScreen.main.bounds.height


    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var trip: Trip
     
    @State var name:String
    @State var startDate: Date
    @State var endDate: Date
    
    
    var body: some View {
        
        VStack(alignment: .center){
            HStack{
                TextField(trip.name, text: $name)
                    .frame(alignment: .leading)
                    //.frame(width: width/4, alignment: .center)
                    .font(.system(.title, design: .rounded))
                    .padding(.horizontal)
            }
            
            Divider()
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
            
            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: [.date])
                .frame(width: width/1.3, alignment: .leading)
            Button{
                TVM.editTrip(trip: trip, name: name, startDate: startDate, endDate: endDate)
                dismiss()
            } label: {
                ZStack{
                    Rectangle().fill(Color(hue: 0.361, saturation: 0.15, brightness: 0.71)).cornerRadius(12).padding()
                        .frame(height: height/10)
                    Text("Update Trip")
                        .foregroundColor(.white)
                }
            }
              Spacer()
        }.toolbar{ToolbarItem{
            Button{
                TVM.deleteTrip(trip: trip)
                
                
                //There is no longer a good way to do this, without updating to a newer version of Xcode
                guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
                navigationController.popToRootViewController(animated: true)
            } label: {
                Image(systemName: "trash")
            }}
        }
    }
}
