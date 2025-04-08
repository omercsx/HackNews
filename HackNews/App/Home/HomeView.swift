//
//  HomeView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

enum StoryType: String {
    case topstories, beststories, newstories
}

struct HomeView: View {
    @State private var filter: StoryType = .topstories
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $filter) {
                    Text("Top").tag(StoryType.topstories)
                    Text("Best").tag(StoryType.beststories)
                    Text("New").tag(StoryType.newstories)
                }.pickerStyle(.segmented)
                
                if filter == .topstories {
                    StoryListView(storyType: filter)
                }
                else if filter == .beststories {
                    StoryListView(storyType: filter)
                }
                else {
                    StoryListView(storyType: filter)
                }
            }
        }
        .navigationTitle("HackFeed")
    }
}

#Preview {
    HomeView()
}
