//
//  TripsViewModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import Foundation

class TripsViewModel: ObservableObject {
    @Published var trips = [Trip]()

    init() {
        parseJSONFile()
    }

    func createTrip(name: String, startDateComponents: DateComponents, endDateComponents: DateComponents) -> Int {
        //convert Date Components to dates
        let startDate = Calendar.current.date(from: startDateComponents)!
        let endDate = Calendar.current.date(from: endDateComponents)!

        //Create each day in the trip
        var days = [Day]()
        let numberOfDays: Int = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day! + 1
        for i in 0 ..< numberOfDays {
            let day = Day(id: i, date: Calendar.current.date(byAdding: .day, value: i, to: startDate)!.timeIntervalSinceReferenceDate, activities: [Activity]())
            days.append(day)
        }

        //Create the trip
        let newTrip = Trip(id: trips.count, name: name, startDate: startDate.timeIntervalSinceReferenceDate, endDate: endDate.timeIntervalSinceReferenceDate, days: days)
        trips.append(newTrip)

        //save the info to json
        writeToJSONFile()
        
        return newTrip.id
    }
    
    func createActivity(day: Day, title: String, startTimeComponents: DateComponents, endTimeComponents: DateComponents, description: String?, url: String?, address: String?) {
        //convert Date Components to dates
        let startTime = Calendar.current.date(from: startTimeComponents)!
        let endTime = Calendar.current.date(from: endTimeComponents)!
        
        let activity = Activity(id: day.activities.count, title: title, startTime: startTime.timeIntervalSinceReferenceDate, endTime: endTime.timeIntervalSinceReferenceDate, description: description == "" ? nil : description, url: url == "" ? nil : url, address: address == "" ? nil : address)
        day.activities.append(activity)

        //orders based on start time
        day.activities.sort{$0.startTime < $1.startTime}
        
        //save the info to json
        writeToJSONFile()
    }
    
    func editActivity(activity: Activity, title: String, startTimeComponents: DateComponents, endTimeComponents: DateComponents, description: String?, url: String?, address: String?) {
        //convert Date Components to dates
        let startTime = Calendar.current.date(from: startTimeComponents)!
        let endTime = Calendar.current.date(from: endTimeComponents)!
        
        activity.title = title
        activity.startTime = startTime.timeIntervalSinceReferenceDate
        activity.endTime = endTime.timeIntervalSinceReferenceDate
        activity.description = description == "" ? nil : description
        activity.url = url == "" ? nil : url
        activity.address = address == "" ? address : address
    }
    
//    func deleteActivity(activity: Activity) {
//        activities.remove(at: activity.id)
//    }
    

    func parseJSONFile(){
        //parse the json file
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = documentDirectory.appendingPathComponent("Trips.json")
            do{
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let jsonData = try jsonDecoder.decode([Trip].self, from: data)

                trips = jsonData
            } catch{
                print(error)
            }
        }
    }

    func writeToJSONFile(){
        //format data into json style
        var topLevel: [AnyObject] = []
        for trip in trips {
            var tripDict: [String: AnyObject] = [:]
            tripDict["id"] = NSNumber(value: trip.id)
            tripDict["name"] = NSString(utf8String: trip.name)
            tripDict["startDate"] = NSNumber(value: trip.startDate)
            tripDict["endDate"] = NSNumber(value: trip.endDate)
            var days: [AnyObject] = []
            for day in trip.days {
                var dayDict: [String: AnyObject] = [:]
                dayDict["id"] = NSNumber(value: day.id)
                dayDict["date"] = NSNumber(value: day.date)
                var activities: [AnyObject] = []
                for activity in day.activities {
                    var activityDict: [String: AnyObject] = [:]
                    activityDict["id"] = NSNumber(value: activity.id)
                    activityDict["title"] = NSString(utf8String: activity.title)
                    activityDict["startTime"] = NSNumber(value: activity.startTime)
                    activityDict["endTime"] = NSNumber(value: activity.endTime)
                    if activity.description != nil {
                        activityDict["description"] = NSString(utf8String: activity.description!)
                    }
                    if activity.url != nil {
                        activityDict["url"] = NSString(utf8String: activity.url!)
                    }
                    if activity.address != nil {
                        activityDict["address"] = NSString(utf8String: activity.address!)
                    }
                    activities.append(activityDict as AnyObject)
                }
                dayDict["activities"] = activities as AnyObject
                days.append(dayDict as AnyObject)
            }
            tripDict["days"] = days as AnyObject
            topLevel.append(tripDict as AnyObject)
        }

        //write to the json file
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: topLevel, options: .prettyPrinted)
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let url = documentDirectory.appendingPathComponent("Trips.json")
                try jsonData.write(to: url)
                print(url)
            }
        } catch {
            print(error)
        }
    }
}
