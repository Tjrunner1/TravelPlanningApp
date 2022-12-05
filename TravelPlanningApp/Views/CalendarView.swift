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
    var numberOfItemsPerRow = 7
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View{
        VStack{
            ForEach(0...Int(trip.days.count/numberOfItemsPerRow), id: \.self) { i in
                HStack{
                    ForEach(createArrayOfDaysDisplay(i: i)) { day in
                        Button{
                            self.dayID = day.id
                        } label: {
                            ZStack{
                                Rectangle().foregroundColor(dayID == day.id ? Color(hue: 0.572, saturation: 0.635, brightness: 0.672).opacity(0.6) : Color(hue: 0.572, saturation: 0.635, brightness: 0.672))
                                    .cornerRadius(10)
                                Text(applyDateFormat(date: day.date)).foregroundColor(.white)
                            }.frame(width: width/CGFloat((numberOfItemsPerRow + 2)), height: height/12)
                        }
                    }
                }
            }

            Divider()
            DayView(day: trip.days[dayID])
        }
    }

    func createArrayOfDaysDisplay(i: Int) -> [Day] {
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

        return dateFormatter.string(from: date)
    }

}


