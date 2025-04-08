import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class FavoritesViewModel: ObservableObject {
    @Published var favoriteStories: [Story] = []
    @Published var favoriteIds: Set<Int> = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    
    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Please login to view favorites"
            return
        }
        
        self.isLoading = true
        self.errorMessage = nil
        
        // Get user's favorite IDs from Firestore
        db.collection("users").document(userId).collection("favorites")
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.favoriteStories = []
                    self.favoriteIds = []
                    return
                }
                
                // Extract story IDs from documents
                let storyIds = documents.compactMap { document -> Int? in
                    guard let storyId = document.data()["storyId"] as? Int else { return nil }
                    return storyId
                }
                
                self.favoriteIds = Set(storyIds)
                
                // Load actual story data for each ID
                self.fetchStoriesDetails(for: storyIds)
            }
    }
    
    private func fetchStoriesDetails(for storyIds: [Int]) {
        guard !storyIds.isEmpty else {
            self.favoriteStories = []
            return
        }
        
        self.isLoading = true
        var loadedStories: [Story] = []
        let dispatchGroup = DispatchGroup()
        
        for storyId in storyIds {
            dispatchGroup.enter()
            
            // Fetch each story detail from Hacker News API
            let urlString = "https://hacker-news.firebaseio.com/v0/item/\(storyId).json"
            guard let url = URL(string: urlString) else {
                dispatchGroup.leave()
                continue
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                defer { dispatchGroup.leave() }
                
                guard let data = data, error == nil else { return }
                
                do {
                    let story = try JSONDecoder().decode(Story.self, from: data)
                    loadedStories.append(story)
                } catch {
                    print("Failed to decode story: \(error)")
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.favoriteStories = loadedStories.sorted(by: { $0.time > $1.time })
        }
    }
    
    func toggleFavorite(story: Story) {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Please login to manage favorites"
            return
        }
        
        let storyId = story.id
        let storyRef = db.collection("users").document(userId).collection("favorites").document("\(storyId)")
        
        if self.favoriteIds.contains(storyId) {
            // Remove from favorites
            storyRef.delete { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Failed to remove from favorites: \(error.localizedDescription)"
                    return
                }
                
                DispatchQueue.main.async {
                    self.favoriteIds.remove(storyId)
                    self.favoriteStories.removeAll { $0.id == storyId }
                }
            }
        } else {
            // Add to favorites
            let data: [String: Any] = [
                "storyId": storyId,
                "title": story.title,
                "addedAt": FieldValue.serverTimestamp()
            ]
            
            storyRef.setData(data) { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    self.errorMessage = "Failed to add to favorites: \(error.localizedDescription)"
                    return
                }
                
                DispatchQueue.main.async {
                    self.favoriteIds.insert(storyId)
                    if !self.favoriteStories.contains(where: { $0.id == storyId }) {
                        self.favoriteStories.append(story)
                        self.favoriteStories.sort(by: { $0.time > $1.time })
                    }
                }
            }
        }
    }
    
    func isFavorite(storyId: Int) -> Bool {
        return favoriteIds.contains(storyId)
    }
} 