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
        VStack(alignment: .leading, spacing: 10) {
            Text(story.title)
                .font(.title3)
                .bold()
            Text("by " + story.by)
            
            HStack(spacing: 50) {
                Text(String(story.score) + " points")
                    .foregroundStyle(.orange)
                    
                Text((story.descendants != nil) ?
                     String(story.descendants!) + " comments" : "0 comments")
                Text(String(story.timeAgo))
            }
            .font(.footnote)
        }
        .frame(
            minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding()
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
        time: 1743449429,
        title: "New antibiotic that kills drug-resistant bacteria found in technician's garden",
        url: "https://www.nature.com/articles/d41586-025-00945-z"
    ))
}
