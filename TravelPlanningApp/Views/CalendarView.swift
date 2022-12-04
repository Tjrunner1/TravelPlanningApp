//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var trip: Trip
    @State var dayID: Int = 0

    var body: some View{
            VStack{
                ForEach(0...Int(trip.days.count/5), id: \.self) { i in
                    HStack{
                        ForEach(createArrayOfDaysDisplay(i: i)) { day in
                            Button{
                                self.dayID = day.id
                            } label: {
                                ZStack{
                                    Rectangle().foregroundColor(dayID == day.id ? Color(hue: 0.572, saturation: 0.635, brightness: 0.672).opacity(0.6) : Color(hue: 0.572, saturation: 0.635, brightness: 0.672))
                                        .cornerRadius(10)
                                    Text(applyDateFormat(date: day.date)).foregroundColor(.white)
                                }.frame(width: 50, height: 75)
                            }
                        }
                    }
                }

                Divider()
                DayView(day: trip.days[dayID])
            }
    }

    func createArrayOfDaysDisplay(i: Int) -> [Day] {
        let numberOfItemsPerRow = 5
        var returnArray: [Day] = []

        for day in trip.days {
            if day.id < numberOfItemsPerRow * (i+1) && day.id >= numberOfItemsPerRow * (i+1) - numberOfItemsPerRow {
                returnArray.append(day)
            }
        }

        return returnArray
    }

    func applyDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"

//        let timeInterval = TimeInterval(timeStamp)
//        let date = Date(timeIntervalSinceReferenceDate: timeInterval)

        return dateFormatter.string(from: date)
    }

}


