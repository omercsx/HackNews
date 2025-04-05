//
//  Story.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation

struct Story: Codable, Identifiable, Hashable {
    let by: String
    var descendants: Int? // the total comment count
    let id: Int
    let kids: [Int]?
    let score: Int
    let text: String?
    let time: TimeInterval //Creation date of the item, in Unix Time
    var timeAgo: String {
        let date = Date(timeIntervalSince1970: time)
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
        if let years = components.year, years > 0 {
            return "\(years) year\(years > 1 ? "s" : "") ago"
        } else if let months = components.month, months > 0 {
            return "\(months) month\(months > 1 ? "s" : "") ago"
        } else if let days = components.day, days > 0 {
            return "\(days) day\(days > 1 ? "s" : "") ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours > 1 ? "s" : "") ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes > 1 ? "s" : "") ago"
        } else if let seconds = components.second, seconds > 0 {
            return "\(seconds) second\(seconds > 1 ? "s" : "") ago"
        } else {
            return "just now"
        }
    }
    let title: String
    let url: String?
}
