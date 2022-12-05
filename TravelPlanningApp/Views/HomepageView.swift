//
//  SelectTripView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

class TimeMgr: ObservableObject {
    var timer = Timer()
    
    @Published var secondsRemaining = 1
    
    init(){
        start()
    }
    
    func start(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            self.secondsRemaining -= 1
        }
    }
}

func format(trip: Trip)->String{
    let TI = Date.now.distance(to: trip.startDate)
    
    //let TI = Date.now.distance(to: Date.init(timeIntervalSinceReferenceDate: TimeInterval(trip.startDate)))
    
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.day]
    formatter.unitsStyle = .positional
    return formatter.string(from: TI)!
    
}


struct HomepageView: View {
    @EnvironmentObject var TVM: TripsViewModel
    var width = UIScreen.main.bounds.width
    
    @ObservedObject var TM = TimeMgr()
    
    init() {
        //check to see if alternate view should be loaded (aka. if the date overlaps with a trip)
        findApplicableTrip()
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                ScrollView{
                    VStack{
                        ForEach(TVM.trips) { trip in
                            if (Date.now.distance(to: trip.endDate) > 0){
                                NavigationLink{
                                    TripView(trip: trip)
                                } label: {
                                    ZStack{
                                        ContainerView(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.896))
                                        VStack{
                                            Text("\(trip.name)").foregroundColor(.black).font(.title)
                                            Text("\(format(trip: trip).replacingOccurrences(of: "d", with: "")) days until trip").foregroundColor(.black).font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                        NavigationLink{
                            CreateTripView()
                        } label: {
                            AddButtonView(color: Color(hue: 0.572, saturation: 0.792, brightness: 0.594))
                        }.frame(width: width)
                    }
                }
            }.navigationTitle("My Trips")
                .navigationBarTitleDisplayMode(.inline)
                .background(alignment: .center, content:{
                    Image("road").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.65)
                })
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

func findApplicableTrip() {
    
}
