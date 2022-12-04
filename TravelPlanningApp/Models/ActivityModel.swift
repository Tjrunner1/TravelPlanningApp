//
//  ActivityModel.swift
//  TravelPlanningApp
//
//  Created by Tyler James on 11/12/22.
//

import Foundation
import UIKit

class Activity: Decodable, Identifiable, ObservableObject {
    var id: Int
    @Published var title: String
    @Published var startTime: Date
    @Published var endTime: Date
    @Published var description: String?
    @Published var url: String?
    @Published var address: String?
    @Published var attachments: [UIImage]?
    
    init(id: Int, title: String, startTime: Date, endTime: Date, description: String?, url: String?, address: String?, attachments: [UIImage]?) {
        self.id = id
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.description = description
        self.url = url
        self.address = address
        self.attachments = attachments
    }
    
    
    private enum CodingKeys : String, CodingKey { case id, title, startTime, endTime, description, url, address, attachments }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.startTime = Date(timeIntervalSinceReferenceDate: try container.decode(Double.self, forKey: .startTime))
        self.endTime = Date(timeIntervalSinceReferenceDate: try container.decode(Double.self, forKey: .endTime))
        self.description = try? container.decode(String.self, forKey: .description)
        self.url = try? container.decode(String.self, forKey: .url)
        self.address = try? container.decode(String.self, forKey: .address)
        
        let attachmentStrings = try? container.decode([String].self, forKey: .attachments)
        if attachmentStrings?.count ?? 0 > 0 {
            self.attachments = [UIImage]()
            for i in 0 ..< attachmentStrings!.count {
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let url = documentDirectory.appendingPathComponent("\(attachmentStrings![i]).png")
                    let image = UIImage(contentsOfFile: url.path)!
                    self.attachments?.append(image)
                }
            }
        }
    }
}

