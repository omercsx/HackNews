//
//  StoryPreviewView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI
import HackNewsShared

struct StoryPreviewView: View {
    let story: Story
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            // Story content link
            NavigationLink(destination: StoryDetailView(story: story)) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(story.title)
                        .multilineTextAlignment(.leading)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                    Text("by " + story.by)
                        .foregroundStyle(.gray)
                    HStack {
                        Text(String(story.score ?? 0) + " points")
                            .foregroundStyle(.orange)
                        Spacer()
                        Text(String(story.descendants) + " comments")
                            .foregroundStyle(.black)
                        Spacer()
                        Text(String(story.timeAgo))
                            .foregroundStyle(.black)
                    }
                    .font(.footnote)
                }
            }
            
            // Favorite button
            if authViewModel.userSession != nil {
                Button {
                    favoritesViewModel.toggleFavorite(story: story)
                } label: {
                    Image(systemName: favoritesViewModel.isFavorite(storyId: story.id) ? "star.fill" : "star")
                        .foregroundColor(favoritesViewModel.isFavorite(storyId: story.id) ? .yellow : .gray)
                        .font(.title2)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .frame(
            minWidth: 0, maxWidth: .infinity, alignment: .topLeading
        )
        .background(Color(UIColor.systemGray5))
        .cornerRadius(15)
    }
}


