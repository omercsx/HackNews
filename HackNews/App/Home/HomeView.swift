//
//  HomeView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var filter = 0
    var body: some View {
        VStack {
            Picker("", selection: $filter) {
                Text("Top").tag(0)
                Text("Best").tag(1)
                Text("New").tag(2)
            }.pickerStyle(.segmented)
            
            if filter == 0 {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        if viewModel.topStories.isEmpty {
                            ProgressView("Loading...")
                                .padding()
                        } else {
                            ForEach(viewModel.topStories) { story in
                                StoryPreviewView(story: story)
                            }
                        }
                    }
                    .padding()
                    .onAppear {
                        viewModel.loadData()
                    }
                }
            }
            else if filter == 1 {
                Text("Best Stories")
            }
            else {
                Text("New Stories")
            }
        
        }
        
    }
}

#Preview {
    HomeView()
}
