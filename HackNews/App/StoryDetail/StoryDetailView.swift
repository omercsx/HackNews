//
//  StoryDetailView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI
import HackNewsShared

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
                        Text(String(story.score ?? 0) + " points")
                            .foregroundStyle(.orange)
                        Spacer()
                        Text(String(story.descendants) + " comments")
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

