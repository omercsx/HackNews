//
//  ContentView.swift
//  HackNews
//
//  Created by Omer Cagri Sayir on 29.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
            } else {
                mainAppTabView
                    .environmentObject(authViewModel)
                    .environmentObject(favoritesViewModel)
            }
        }
    }
    
    var mainAppTabView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("HackFeed", systemImage: "newspaper")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
