//
//  StoryDetailView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct StoryDetailView: View {
    
    let story: Story
    @State private var showComments: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(story.title)
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        if authViewModel.userSession != nil {
                            Button {
                                favoritesViewModel.toggleFavorite(story: story)
                            } label: {
                                Image(systemName: favoritesViewModel.isFavorite(storyId: story.id) ? "star.fill" : "star")
                                    .foregroundColor(favoritesViewModel.isFavorite(storyId: story.id) ? .yellow : .gray)
                                    .font(.title2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    Text("by " + story.by)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Text(String(story.score) + " points")
                            .foregroundStyle(.orange)
                        Spacer()
                        Text(String(story.descendants ?? 0) + " comments")
                        Spacer()
                        Text(String(story.timeAgo))
                    }
                    
                    if (story.text != nil) {
                        Text(Common.decodeHTML(story.text!))
                    }
                    
                    if (story.url != nil) {
                        Link("External Link", destination: URL(string: story.url!)!)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Spacer()
                    
                    if (story.kids != nil && !story.kids!.isEmpty) {
                        Button(action: {
                            showComments.toggle()
                        }, label: {
                            Text(showComments ? "Hide Comments" : "View Comments")
                                .foregroundStyle(.orange)
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding()
                
                if showComments {
                    CommentView(commentIds: story.kids!, op: story.by)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        StoryDetailView(story: Story(
            by: "rbizyrbiz",
            descendants: 0,
            id: 43587764,
            kids: nil,
            score: 2,
            text: "Sample story text for preview purposes...",
            time: 1743802094,
            title: "I'm So Bored with the USA",
            url: "External Link"
        ))
        .environmentObject(AuthViewModel())
        .environmentObject(FavoritesViewModel())
    }
}
