//
//  CalendarView.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var trip: Trip
    @State var day: Day
    var numberOfItemsPerRow = 7
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    var body: some View{
        VStack{
            ForEach(0...Int(trip.days.count/numberOfItemsPerRow), id: \.self) { i in
                HStack{
                    ForEach(createArrayOfDaysDisplay(i: i)) { day in
                        Button{
                            self.day = day
                        } label: {
                            ZStack{
                                Rectangle().foregroundColor(self.day.id == day.id ? Color(hue: 0.261, saturation: 0.075, brightness: 0.71).opacity(0.6): Color(hue: 0.261, saturation: 0.075, brightness: 0.71))
                                    .cornerRadius(10)
                                    .cornerRadius(10)
                                Text(applyDateFormat(date: day.date)).foregroundColor(.white)
                            }.frame(width: width/CGFloat((numberOfItemsPerRow + 2)), height: height/12)
                        }
                    }
                }
            }
            Divider()
            DayView(day: self.day)
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


