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
    var TVM = TripsViewModel()
    var width = UIScreen.main.bounds.width
    @State var activateHiddenView: Bool
    var trip: Trip?
    var dayID: Int?
    @ObservedObject var TM = TimeMgr()
    
    init() {
        let currentDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month,. day], from: Date.now))!
        for trip in TVM.trips {
            if (trip.startDate <= currentDate && currentDate <= trip.endDate) {
                self.trip = trip
                self.dayID = 0
                for i in 0 ..< trip.days.count {
                    if (trip.days[i].date <= currentDate) {
                        dayID = trip.days[i].id
                    }
                }
            }
        }
        if (trip != nil) {
            self.activateHiddenView = true
        } else {
            self.activateHiddenView = false
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{

                    VStack{
                        ForEach(TVM.trips) { trip in

                            NavigationLink{
                                //TripView(trip: trip)
                                Tabs(trip: trip)
                            } label: {
                                ZStack{
                                    //ContainerView(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.896))
                                    ContainerView(color: Color(hue: 0.084, saturation: 0.132, brightness: 0.821))
                                    VStack{
                                        Text("\(trip.name)").foregroundColor(.white).font(.title)
                                        if Date.now <= trip.startDate {

                                            Text("\(format(trip: trip).replacingOccurrences(of: "d", with: "")) days until trip").foregroundColor(.white).font(.caption)
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
                        
                        if activateHiddenView {
                            NavigationLink(isActive: $activateHiddenView){
                                Tabs(trip: trip!, dayID: dayID!)
                                //TripView(trip: trip!, dayID: dayID!)
                            } label: {
                                EmptyView()
                            }
                        }
                        
                    }
                }
            }.navigationTitle("My Trips")
                .navigationBarTitleDisplayMode(.inline)
                .background(alignment: .center, content:{
                    Image("road").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.65)
                })
        }.navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(TVM)
    }
}
