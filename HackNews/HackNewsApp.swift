//
//  HackNewsApp.swift
//  HackNews
//
//  Created by Omer Cagri Sayir on 29.03.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {

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

    return true
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
