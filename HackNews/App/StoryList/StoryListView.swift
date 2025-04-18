//
//  StoryListView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-05.
//

import SwiftUI

struct StoryListView: View {
    let storyType: StoryType
    @StateObject var viewModel = StoryListViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10)
            {
                if viewModel.stories.isEmpty {
                    ProgressView("Loading...")
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                } else {
                    ForEach(viewModel.stories, id: \.self) { story in
                        StoryPreviewView(story: story)
                            .environmentObject(authViewModel)
                            .environmentObject(favoritesViewModel)
                            .onAppear {
                                Task {
                                    viewModel.shouldLoadMore(id: story.id, storyType: storyType)
                                }
                            }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadStories(storyType: storyType)
        }
        .refreshable {
            viewModel.reloadStories(storyType: storyType)
        }
    }
}

#Preview {
    StoryListView(storyType: .topstories)
        .environmentObject(AuthViewModel())
        .environmentObject(FavoritesViewModel())
}
