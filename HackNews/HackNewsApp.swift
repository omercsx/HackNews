//
//  HackNewsApp.swift
//  HackNews
//
//  Created by Omer Cagri Sayir on 29.03.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

    FirebaseApp.configure()

    // Set up Firestore settings if needed
    let db = Firestore.firestore()
    let settings = db.settings
    // Uncomment to use local emulator for testing
    // settings.host = "localhost:8080"
    // settings.isSSLEnabled = false
    db.settings = settings
    
    // Configure notification handling
    UNUserNotificationCenter.current().delegate = self
    
    // Set up notification categories
    SystemNotification.shared.setupNotificationCategories()
    
    return true
  }
  
  // Handle notifications when app is in foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, 
                              willPresent notification: UNNotification, 
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    // Show notification banner even when app is in foreground
    completionHandler([.banner, .sound])
  }
  
  // Handle notification response
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    let categoryIdentifier = response.notification.request.content.categoryIdentifier
    
    switch response.actionIdentifier {
    case UNNotificationDefaultActionIdentifier:
        // User tapped the notification
        if categoryIdentifier == "FAVORITE_CATEGORY" {
            // Handle tapping on favorite notification
            print("User tapped on favorite notification")
        }
    case "OPEN_ACTION":
        // User tapped the open action
        print("User tapped open action")
    default:
        break
    }
    
    completionHandler()
  }
}

@main
struct HackNewsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
