//
//  Story.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation

struct Story: Codable {
    let id: Int
    let by: String
    let title: String
    let url: String
    let descendants: Int // the total comment count
    let kids: [Int]
    let score: Int
    let time: Int //Creation date of the item, in Unix Time
}
