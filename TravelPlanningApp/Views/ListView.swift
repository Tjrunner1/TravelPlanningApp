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
            TextView(text: $trip.list)
                .padding(10)
                .border(Color.primary, width: 0.5)
                .padding()
            Button{
                TVM.updateList(trip: trip, list: trip.list)
            } label: {
                ZStack{
                    Rectangle().frame(width: width/2, height: height/10).cornerRadius(10)
                        .foregroundColor(Color(hue: 0.572, saturation: 0.5, brightness: 0.7))
                    Text("Save").foregroundColor(.white).font(.system(.title2, design: .rounded))
                }.padding()
            }
        }
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListView()
//    }
//}
