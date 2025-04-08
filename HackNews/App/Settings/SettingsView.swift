//
//  SettingsView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationStack {
            List {
                if let user = authViewModel.user {
                    Section(header: Text("Account")) {
                        NavigationLink(destination: ProfileView()) {
                            HStack {
                                Text(String(user.fullname.isEmpty ? user.email.prefix(1).uppercased() : user.fullname.prefix(1).uppercased()))
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    if !user.fullname.isEmpty {
                                        Text(user.fullname)
                                            .font(.headline)
                                    }
                                    
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section(header: Text("Preferences")) {
//                    Toggle("Dark Mode", isOn: $isDarkMode)
//                        .onChange(of: isDarkMode) { _ in
//                            // To be implemented when theme handling is added
//                        }
                    
                    Toggle("Favorite Notifications", isOn: $favoritesViewModel.notificationsEnabled)
                        .onChange(of: favoritesViewModel.notificationsEnabled) { _ in
                            favoritesViewModel.toggleNotifications()
                        }
                }
                
                Section(header: Text("About")) {
                    Link("Visit Website", destination: URL(string: "https://news.ycombinator.com")!)
                    Link("Privacy Policy", destination: URL(string: "https://news.ycombinator.com/newsguidelines.html")!)
                    Link("Terms of Service", destination: URL(string: "https://news.ycombinator.com/newsguidelines.html")!)
                }
                
                if authViewModel.userSession != nil {
                    Section {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                checkNotificationPermission()
            }
        }
    }
    
    private func checkNotificationPermission() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus != .authorized {
                    favoritesViewModel.notificationsEnabled = false
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
        .environmentObject(FavoritesViewModel())
}
