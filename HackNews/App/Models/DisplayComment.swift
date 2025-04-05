//
//  DisplayComment.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import Foundation

struct DisplayComment: Identifiable {
    let by: String
    let id: Int
    let kids: [Int]
    let parent: Int
    let text: String
    let timeAgo: String
    var showKidComments: Bool = false
    var kidComments: [DisplayComment] = []
}
