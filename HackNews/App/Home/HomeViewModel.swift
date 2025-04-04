//
//  HomeViewModel.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation
final class HomeViewModel: ObservableObject {
    @Published var topStories: [Story] = []
    
    func getTopStories() async throws -> [Int] {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let idList = try JSONDecoder().decode([Int].self, from: data)
        return idList
    }
    
    func getStoryById(id: Int) async throws -> Story {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/" + String(id) + ".json?print=pretty")!
        let (data, _) = try await URLSession.shared.data(from: url)
        var story = try JSONDecoder().decode(Story.self, from: data)
        if (story.descendants == nil) {
            story.descendants = 0
        }
        return story
    }

    func loadData() {
        Task {
            self.topStories = []
            let idList = try await getTopStories()
            do {
                for i in 0...9 {
                    let story = try await getStoryById(id: idList[i])
                    self.topStories.append(story)
                }
            } catch {
                print("Error loading top stories: \(error)")
            }
        }
    }

}
