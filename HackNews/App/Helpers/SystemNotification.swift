import SwiftUI
import UserNotifications

enum NotificationType {
    case favorite
    case story
    case comment
}

class SystemNotification {
    static let shared = SystemNotification()
    let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
    }
    
    func checkAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
    
    func sendNotification(type: NotificationType, title: String, body: String, identifier: String, timeInterval: TimeInterval = 1) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        // Create a category identifier based on notification type
        switch type {
        case .favorite:
            content.categoryIdentifier = "FAVORITE_CATEGORY"
        case .story:
            content.categoryIdentifier = "STORY_CATEGORY"
        case .comment:
            content.categoryIdentifier = "COMMENT_CATEGORY"
        }
        
        // Create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Add request
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func clearAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.removeAllDeliveredNotifications()
    }
    
    func setupNotificationCategories() {
        // Create actions for favorite notifications
        let openAction = UNNotificationAction(
            identifier: "OPEN_ACTION",
            title: "View",
            options: .foreground
        )
        
        // Create favorite category
        let favoriteCategory = UNNotificationCategory(
            identifier: "FAVORITE_CATEGORY",
            actions: [openAction],
            intentIdentifiers: [],
            options: []
        )
        
        // Register categories
        notificationCenter.setNotificationCategories([favoriteCategory])
    }
} 