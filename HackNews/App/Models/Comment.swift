//
//  Comment.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation

struct Comment: Codable {
    let by: String?
    let id: Int
    let kids: [Int]?
    let parent: Int
    let text: String?
    let time: TimeInterval
}
