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
        NavigationView {
            VStack {
                Picker("", selection: $filter) {
                    Text("Top").tag(0)
                    Text("Best").tag(1)
                    Text("New").tag(2)
                }.pickerStyle(.segmented)
                
                
                if filter == 0 { // top
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
                    }
                    .onAppear {
                        if (viewModel.topStories.isEmpty) {
                            viewModel.loadTopStories()
                        }
                    }
                    .refreshable {
                        viewModel.loadTopStories()
                    }
                    
                }
                else if filter == 1 { // best
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            if viewModel.bestStories.isEmpty {
                                ProgressView("Loading...")
                                    .padding()
                            } else {
                                ForEach(viewModel.bestStories) { story in
                                    StoryPreviewView(story: story)
                                }
                            }
                        }
                        .padding()
                    }
                    .onAppear {
                        if viewModel.bestStories.isEmpty {
                            viewModel.loadBestStories()
                        }
                    }
                    .refreshable {
                        viewModel.loadBestStories()
                    }
                }
                else { // new
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            if viewModel.newStories.isEmpty {
                                ProgressView("Loading...")
                                    .padding()
                            } else {
                                ForEach(viewModel.newStories) { story in
                                    StoryPreviewView(story: story)
                                }
                            }
                        }
                        .padding()
                    }
                    .onAppear {
                        if viewModel.newStories.isEmpty {
                            viewModel.loadNewStories()
                        }
                    }
                    .refreshable {
                        viewModel.loadNewStories()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
