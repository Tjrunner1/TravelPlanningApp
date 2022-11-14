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
    
    func addTrip(name: String, startDate: Double, endDate: Double) -> Trip {
        var days = [Day]()
        let numberOfDays: Int = Int(endDate - startDate)
        for i in 1 ... numberOfDays {
            let day = Day(id: i, activities: [Activity]())
            days.append(day)
        }
        let trip = Trip(id: trips.count + 1, name: name, startDate: startDate, endDate: endDate, days: days)
        trips.append(trip)
        
        writeToJSONFile()
        
        return trip
    }
    
    func addActivity(tripID: Int, dayID: Int, title: String, startTime: Double, endTime: Double, description: String = "") {
        let activity = Activity(id: trips[tripID].days[dayID].activities.count + 1, title: title, startTime: startTime, endTime: endTime, description: description)
        trips[tripID].days[dayID].activities.append(activity)

        writeToJSONFile()
    }
    
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
                var activities: [AnyObject] = []
                for activity in day.activities {
                    var activityDict: [String: AnyObject] = [:]
                    activityDict["id"] = NSNumber(value: activity.id)
                    activityDict["title"] = NSString(utf8String: activity.title)
                    activityDict["startTime"] = NSNumber(value: activity.startTime)
                    activityDict["endTime"] = NSNumber(value: activity.endTime)
                    activityDict["description"] = NSString(utf8String: activity.description ?? "")
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
