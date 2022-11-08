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
//        parseJSONFile()
        tempTripsData()
    }
    
    func parseJSONFile(){
    
        // 1. pathString
        let pathString = Bundle.main.path(forResource: "games", ofType: "json")
        if let path = pathString{
            // 2. URL
            let url = URL(fileURLWithPath: path)
            // 3. Data object
            do{
                let data = try Data(contentsOf: url)
                // 4. json decoder
                let jsonDecoder = JSONDecoder()
                // 5. get json data
                // var jsonData = try jsonDecoder.decode([People].self, from: data)
                let jsonData = try jsonDecoder.decode([Trip].self, from: data)
                
                trips = jsonData
            } catch{
                print(error)
            }
        }
    }
    
    func tempTripsData() {
        let trip1 = Trip(id: 1, name: "Rome Trip")
        let trip2 = Trip(id: 2, name: "Camping Trip")
        let trip3 = Trip(id: 3, name: "New York City Trip")
        
        trips.append(trip1)
        trips.append(trip2)
        trips.append(trip3)
    }
}
