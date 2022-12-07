//
//  ListView.swift
//  TravelPlanningApp
//
//  Created by Tori Keener on 12/6/22.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var TVM: TripsViewModel
    @ObservedObject var trip: Trip
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height

    var body: some View {
        VStack{
            Text("Packing List").font(.title)
            TextView(text: $trip.list)
                .padding(10)
                .padding()
            Button{
                TVM.updateList(trip: trip, list: trip.list)
            } label: {
                ZStack{
                    Rectangle().fill(Color(hue: 0.361, saturation: 0.15, brightness: 0.71)).cornerRadius(12).padding()
                        .frame(height: height/10)
                    Text("Save")
                        .foregroundColor(.white)
                }.padding()
            }
        }
    }
}

