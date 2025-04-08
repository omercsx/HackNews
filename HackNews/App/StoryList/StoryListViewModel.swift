//
//  StoryListViewModel.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-05.
//

import Foundation
import HackNewsShared

final class StoryListViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    private var fetchedStoryIds: [Int] = []
    private let maxFetchStories = 10
    private var loadedStories = 0
    private let maxStories = 500
    
    private func getAllStoryIds(storyType: StoryType) async throws {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/\(storyType).json?print=pretty")!
        let (data, _) = try await URLSession.shared.data(from: url)
        fetchedStoryIds = try JSONDecoder().decode([Int].self, from: data)
    }
    
    private func getStoryById(id: Int) async throws -> Story {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/" + String(id) + ".json?print=pretty")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedStory = try JSONDecoder().decode(Story.self, from: data)
        
        // Create a new Story instance with default value for descendants if nil
        return Story(
            id: decodedStory.id,
            title: decodedStory.title,
            url: decodedStory.url,
            score: decodedStory.score,
            by: decodedStory.by,
            time: decodedStory.time,
            descendants: decodedStory.descendants ?? 0,
            text: decodedStory.text,
            kids: decodedStory.kids
        )
    }
    
    func reloadStories(storyType: StoryType) { // pull down to refresh
        self.fetchedStoryIds.removeAll()
        self.stories.removeAll()
        self.loadedStories = 0
        
        self.loadStories(storyType: storyType)
    }
    
    func shouldLoadMore(id: Int, storyType: StoryType) {
        if id == self.stories.last?.id {
            print("should load more")
            loadStories(storyType: storyType)
        }
    }
    
    func loadStories(storyType: StoryType) {
        if (self.loadedStories == maxStories) { // api supports 500 stories at most
            return
        }
        Task {
            do {
                if (self.fetchedStoryIds.isEmpty) {
                    try await self.getAllStoryIds(storyType: storyType)
                }
                for index in 0..<maxFetchStories {
                    self.loadedStories += 1
                    let story = try await getStoryById(id: fetchedStoryIds[index])
                    if !self.stories.contains(where: { $0.id == story.id }) {
                        self.stories.append(story)
                    }
                }
                fetchedStoryIds.removeSubrange(0..<maxFetchStories)
            }
            catch {
                print("load stories failed: \(error)")
            }
        }
    }
}
