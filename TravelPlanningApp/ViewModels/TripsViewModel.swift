//
//  TripsViewModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import Foundation

class TripsViewModel: ObservableObject {
    @Published var trips = [Trip]()
    var tripIDCounter = 0
    var activityIDCounter = 0

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
            let day = Day(id: i, date: Calendar.current.date(byAdding: .day, value: i, to: startDate)!, activities: [Activity]())
            days.append(day)
        }

        //Create the trip
        let newTrip = Trip(id: tripIDCounter, name: name, startDate: startDate, endDate: endDate, days: days)
        trips.append(newTrip)
        tripIDCounter += 1

        //save the info to json
        writeToJSONFile()
        
        return newTrip.id
    }
    
    func editTrip(trip: Trip, name: String, startDateComponents: DateComponents, endDateComponents: DateComponents) {
        //convert Date Components to dates
        let startDate = Calendar.current.date(from: startDateComponents)!
        let endDate = Calendar.current.date(from: endDateComponents)!
        
        //Create each day in the trip
        var days = [Day]()
        let numberOfDays: Int = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day! + 1
        for i in 0 ..< numberOfDays {
            let day = Day(id: i, date: Calendar.current.date(byAdding: .day, value: i, to: startDate)!, activities: [Activity]())
            for oldDay in trip.days {
                if oldDay.date == day.date {
                    day.activities = oldDay.activities
                }
            }
            days.append(day)
        }
        
        //update data
        trip.name = name
        trip.startDate = startDate
        trip.endDate = endDate
        trip.days = days
        
        //save the info to json
        writeToJSONFile()
    }
    
    func deleteTrip(trip: Trip) {
        for i in 0 ..< trips.count {
            if trips[i].id == trip.id {
                trips.remove(at: i)
                return
            }
        }
        
        //save the info to json
        writeToJSONFile()
    }
    
    func createActivity(day: Day, title: String, startTimeComponents: DateComponents, endTimeComponents: DateComponents, description: String?, url: String?, address: String?) {
        //convert Date Components to dates
        let startTime = Calendar.current.date(from: startTimeComponents)!
        let endTime = Calendar.current.date(from: endTimeComponents)!
        
        let activity = Activity(id: activityIDCounter, title: title, startTime: startTime, endTime: endTime, description: description == "" ? nil : description, url: url == "" ? nil : url, address: address == "" ? nil : address)
        day.activities.append(activity)
        activityIDCounter += 1

        //orders based on start time
        day.activities.sort{$0.startTime < $1.startTime}
        
        //save the info to json
        writeToJSONFile()
    }
    
    func updateActTitle(activity: Activity, title: String?){
        if (title != nil){
            activity.title = title!
            writeToJSONFile()
        }
    }
    
    func editActivity(activity: Activity, title: String, startTimeComponents: DateComponents, endTimeComponents: DateComponents, description: String?, url: String?, address: String?) {
        //convert Date Components to dates
        let startTime = Calendar.current.date(from: startTimeComponents)!
        let endTime = Calendar.current.date(from: endTimeComponents)!
        
        //update data
        activity.title = title
        activity.startTime = startTime
        activity.endTime = endTime
        activity.description = description == "" ? nil : description
        activity.url = url == "" ? nil : url
        activity.address = address == "" ? address : address
        
        //save the info to json
        writeToJSONFile()
    }
    
    func deleteActivity(activity: Activity) {
        for i in 0 ..< trips.count {
            for j in 0 ..< trips[i].days.count {
                for k in 0 ..< trips[i].days[j].activities.count {
                    if trips[i].days[j].activities[k].id == activity.id {
                        trips[i].days[j].activities.remove(at: k)
                        return
                    }
                }
            }
        }
        
        //save the info to json
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
            tripDict["startDate"] = NSNumber(value: trip.startDate.timeIntervalSinceReferenceDate)
            tripDict["endDate"] = NSNumber(value: trip.endDate.timeIntervalSinceReferenceDate)
            var days: [AnyObject] = []
            for day in trip.days {
                var dayDict: [String: AnyObject] = [:]
                dayDict["id"] = NSNumber(value: day.id)
                dayDict["date"] = NSNumber(value: day.date.timeIntervalSinceReferenceDate)
                var activities: [AnyObject] = []
                for activity in day.activities {
                    var activityDict: [String: AnyObject] = [:]
                    activityDict["id"] = NSNumber(value: activity.id)
                    activityDict["title"] = NSString(utf8String: activity.title)
                    activityDict["startTime"] = NSNumber(value: activity.startTime.timeIntervalSinceReferenceDate)
                    activityDict["endTime"] = NSNumber(value: activity.endTime.timeIntervalSinceReferenceDate)
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
