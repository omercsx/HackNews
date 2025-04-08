//
//  Common.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation
import UIKit // for NSAttributedString

struct Common {
    static func UnixTimeToTimeAgo(time: TimeInterval) -> String {
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
    
    static func decodeHTML(_ html: String) -> String {
        guard let data = html.data(using: .utf8) else { return html }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributedString?.string ?? html
    }
}
