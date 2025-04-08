import Foundation

public struct Story: Identifiable, Codable, Hashable {
    public let id: Int
    public let title: String
    public let url: String?
    public let score: Int?
    public let by: String
    public let time: TimeInterval
    public let descendants: Int
    public let text: String?
    public let kids: [Int]?
    
    public init(id: Int, title: String, url: String?, score: Int?, by: String, time: TimeInterval, descendants: Int, text: String? = nil, kids: [Int]? = nil) {
        self.id = id
        self.title = title
        self.url = url
        self.score = score
        self.by = by
        self.time = time
        self.descendants = descendants
        self.text = text
        self.kids = kids
    }
    
    public static var placeholder: Story {
        Story(id: 0,
             title: "Loading...",
             url: nil,
             score: 0,
             by: "user",
             time: Date().timeIntervalSince1970,
             descendants: 0)
    }
    
    public var timeAgo: String {
        let now = Date().timeIntervalSince1970
        let seconds = Int(now - time)
        
        let minute = 60
        let hour = minute * 60
        let day = hour * 24
        let week = day * 7
        let month = day * 30
        let year = day * 365
        
        switch seconds {
        case 0..<minute:
            return "\(seconds) seconds ago"
        case minute..<hour:
            let minutes = seconds / minute
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        case hour..<day:
            let hours = seconds / hour
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        case day..<week:
            let days = seconds / day
            return "\(days) day\(days == 1 ? "" : "s") ago"
        case week..<month:
            let weeks = seconds / week
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        case month..<year:
            let months = seconds / month
            return "\(months) month\(months == 1 ? "" : "s") ago"
        default:
            let years = seconds / year
            return "\(years) year\(years == 1 ? "" : "s") ago"
        }
    }
} 
