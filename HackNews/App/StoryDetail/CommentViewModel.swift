//
//  StoryDetailViewModel.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation
final class CommentViewModel: ObservableObject {
    
    func getComments(ids: [Int]) async -> [DisplayComment] {
        var comments: [DisplayComment] = []
        do {
            for id in ids {
                let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(String(id)).json?print=pretty")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let comment = try JSONDecoder().decode(Comment.self, from: data)
                let displayComment = DisplayComment(
                    by: comment.by ?? "[unknown]",
                    id: comment.id,
                    kids: comment.kids ?? [],
                    parent: comment.parent,
                    text: comment.text ?? "[empty comment]",
                    timeAgo: Common.UnixTimeToTimeAgo(time: comment.time)
                )
                comments.append(displayComment)
            }
        }
        catch {
            print("error loading comments: \(error)")
        }
        return comments
    }
}
