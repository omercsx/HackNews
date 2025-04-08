import Foundation

public class StoryService {
    public static let shared = StoryService()
    
    private let baseURL = "https://hacker-news.firebaseio.com/v0"
    private let session = URLSession.shared
    
    private init() {}
    
    public func fetchTopStories(count: Int = 10) async throws -> [Story] {
        let url = URL(string: "\(baseURL)/topstories.json")!
        let (data, _) = try await session.data(from: url)
        let storyIds = try JSONDecoder().decode([Int].self, from: data)
        
        let stories = try await withThrowingTaskGroup(of: Story?.self) { group in
            var stories: [Story] = []
            
            for id in storyIds.prefix(count) {
                group.addTask {
                    try? await self.fetchStory(id: id)
                }
            }
            
            for try await story in group {
                if let story = story {
                    stories.append(story)
                }
            }
            
            return stories.sorted { $0.score ?? 0 > $1.score ?? 0 }
        }
        
        return stories
    }
    
    private func fetchStory(id: Int) async throws -> Story {
        let url = URL(string: "\(baseURL)/item/\(id).json")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(Story.self, from: data)
    }
} 