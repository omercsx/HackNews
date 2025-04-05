//
//  StoryPreviewView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct StoryPreviewView: View {
    
    let story: Story
    
    var body: some View {
        NavigationLink(destination: StoryDetailView(story: story)) {
            VStack(alignment: .leading, spacing: 10) {
                Text(story.title)
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.black)
                Text("by " + story.by)
                    .foregroundStyle(.gray)
                HStack {
                    Text(String(story.score) + " points")
                        .foregroundStyle(.orange)
                    Spacer()
                    Text(String(story.descendants!) + " comments")
                        .foregroundStyle(.black)
                    Spacer()
                    Text(String(story.timeAgo))
                        .foregroundStyle(.black)
                }
                .font(.footnote)
            }
            .padding()
            .frame(
                minWidth: 0, maxWidth: .infinity, alignment: .topLeading
            )
        }
        .background(Color(UIColor.systemGray5))
        .cornerRadius(15)
    }
}

#Preview {
    StoryPreviewView(story: Story(
        by: "ascorbic",
        descendants: 195,
        id: 43538853,
        kids: [ 43579483, 43579062, 43585110, 43579065, 43580486, 43578638, 43579421, 43583435, 43579827, 43583488, 43581030, 43579018, 43584722, 43580369, 43581078, 43580625, 43579548 ],
        score: 292,
        text: nil,
        time: 1743449429,
        title: "New antibiotic that kills drug-resistant bacteria found in technician's garden",
        url: "https://www.nature.com/articles/d41586-025-00945-z"
    ))
}
