//
//  TripsViewModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/8/22.
//

import Foundation
import UIKit

class TripsViewModel: ObservableObject {
    @Published var trips = [Trip]()
    var tripIDCounter = 0
    var activityIDCounter = 0

    init() {
        parseJSONFile()
    }

    func createTrip(name: String, startDate: Date, endDate: Date) -> Int {
        //Get percise date
        let startDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: startDate))!
        let endDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: endDate))!

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
    
    func editTrip(trip: Trip, name: String, startDate: Date, endDate: Date) {
        //Get percise date
        let startDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: startDate))!
        let endDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: endDate))!
        
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
    
    func createActivity(day: Day, title: String, startTime: Date, endTime: Date, description: String?, url: String?, address: String?, attachments: [UIImage]?) {
        //Get percise date
        let startTime = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: startTime))!
        let endTime = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: endTime))!
        
        //create the activity
        let activity = Activity(id: activityIDCounter, title: title, startTime: startTime, endTime: endTime, description: description == "" ? nil : description, url: url == "" ? nil : url, address: address == "" ? nil : address, attachments: attachments?.count == 0 ? nil : attachments)
        day.activities.append(activity)
        activityIDCounter += 1

        //orders based on start time
        day.activities.sort{$0.startTime < $1.startTime}
        
        //save the info to json
        writeToJSONFile()
        addImagesToFilePath(activity: activity)
    }
    
    func editActivity(activity: Activity, title: String, startTime: Date, endTime: Date, description: String?, url: String?, address: String?, attachments: [UIImage]?) {
        //Get percise date
        let startTime = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: startTime))!
        let endTime = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: endTime))!
        
        //update data
        activity.title = title
        activity.startTime = startTime
        activity.endTime = endTime
        activity.description = description == "" ? nil : description
        activity.url = url == "" ? nil : url
        activity.address = address == "" ? nil : address
        activity.attachments = attachments?.count == 0 ? nil : attachments
        
        //save the info to json
        writeToJSONFile()
        addImagesToFilePath(activity: activity)
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
        
        
        for i in 0 ..< trips.count {
            if trips[i].id >= tripIDCounter {
                tripIDCounter = trips[i].id + 1
            }
            for j in 0 ..< trips[i].days.count {
                for k in 0 ..< trips[i].days[j].activities.count {
                    if trips[i].days[j].activities[k].id >= activityIDCounter {
                        activityIDCounter = trips[i].days[j].activities[k].id + 1
                    }
                }
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
                    if activity.attachments != nil {
                        var attachmentArray: [String] = []
                        for i in 0 ..< activity.attachments!.count {
                            let string = NSString(utf8String: "\(activity.id)_\(i).png")
                            attachmentArray.append(string! as String)
                        }
                        activityDict["attachments"] = attachmentArray as AnyObject
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
    
    func addImagesToFilePath(activity: Activity) {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                for i in 0 ..< (activity.attachments?.count ?? 0) {
                    if let data = activity.attachments![i].pngData() {
                        let url = documentDirectory.appendingPathComponent("\(activity.id)_\(i).png")
                        
                        try data.write(to: url)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}
