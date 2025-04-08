//
//  FavoritesView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel = FavoritesViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if authViewModel.userSession == nil {
                    // User not logged in
                    VStack(spacing: 20) {
                        Text("Please sign in to view your favorites")
                            .font(.headline)
                        
                        NavigationLink {
                            LoginView()
                                .environmentObject(authViewModel)
                        } label: {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 44)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                } else if viewModel.isLoading {
                    // Loading state
                    ProgressView("Loading favorites...")
                } else if let errorMessage = viewModel.errorMessage {
                    // Error state
                    VStack(spacing: 16) {
                        Text("Error")
                            .font(.title)
                            .foregroundColor(.red)
                        
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            viewModel.loadFavorites()
                        } label: {
                            Text("Try Again")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 120, height: 44)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                } else if viewModel.favoriteStories.isEmpty {
                    // No favorites
                    VStack(spacing: 16) {
                        Text("No Favorites")
                            .font(.title)
                            .foregroundColor(.gray)
                        
                        Text("Stories you favorite will appear here")
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else {
                    // Display favorites
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.favoriteStories, id: \.id) { story in
                                StoryPreviewView(story: story)
                                    .environmentObject(viewModel)
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        viewModel.loadFavorites()
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.loadFavorites()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .onAppear {
            if authViewModel.userSession != nil {
                viewModel.loadFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(AuthViewModel())
}
