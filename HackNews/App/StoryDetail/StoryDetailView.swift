//
//  StoryDetailView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct StoryDetailView: View {
    
    let story: Story
    @State private var showComments: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(story.title)
                .font(.title2)
                .bold()
            Text("by " + story.by)
                .foregroundStyle(.gray)
            HStack(spacing: 30) {
                Text(String(story.score) + " points")
                    .foregroundStyle(.orange)
                    
                Text(String(story.descendants!) + " comments")
                Text(String(story.timeAgo))
            }
            if (story.text != nil) {
                Text(story.text!)
            }
            if (story.url != nil) {
                Link("External Link", destination: URL(string: story.url!)!)
            }
            Spacer()
            if (story.kids != nil && !story.kids!.isEmpty) {
                Button(action: {
                    showComments.toggle()
                }, label: {
                    Text(showComments ? "Hide Comments" : "View Comments")
                        .foregroundStyle(.orange)
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if showComments {
                ScrollView {
                    CommentView(commentIds: story.kids!)
                        .padding(.top)
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    StoryDetailView(story: Story(
        by: "rbizyrbiz",
        descendants: 0,
        id: 43587764,
        kids: nil,
        score: 2,
        text: "I'm living on a small SaaS that will hopefully sustain myself into retirement and give a little income (have had some past exits that I am lucky for, this one will probably cap out on TAM, but good enough) That said, I'm funding & developing this all myself and I'm looking to move myself and the company out of the US. I'm sure the US is still the top place to run a startup for financial & networking reasons, but I don't need that for this one and I'd rather deal with a little more red tape in a country I feel aligns better w my values. I'm just curious if anyone has made this kind of move , and any advice on how to do it right for a small 1-2 person profitable LLC?",
        time: 1743802094,
        title: "I'm So Bored with the USA",
        url: nil
    ))
}
