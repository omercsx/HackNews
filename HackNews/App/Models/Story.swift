//
//  Story.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation

struct Story: Codable, Identifiable, Hashable {
    let by: String
    var descendants: Int? // the total comment count
    let id: Int
    let kids: [Int]?
    let score: Int
    let text: String?
    let time: TimeInterval //Creation date of the item, in Unix Time
    var timeAgo: String {
        return Common.UnixTimeToTimeAgo(time: time)
    }
    let title: String
    let url: String?
}
