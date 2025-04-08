//
//  ContentView.swift
//  HackNews
//
//  Created by Omer Cagri Sayir on 29.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
            } else {
                mainAppTabView
                    .environmentObject(authViewModel)
            }
        }
    }
    
    var mainAppTabView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("HackFeed", systemImage: "newspaper")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
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
