//
//  CommentView.swift
//  HackNews
//
//  Created by Chaoyi Wu on 2025-04-04.
//

import SwiftUI

struct CommentView: View {
    @StateObject var viewModel = CommentViewModel()
    
    let commentIds: [Int]
    
    @State private var comments: [DisplayComment] = []
    
    @ViewBuilder
    func createCommentSection(comment: Binding<DisplayComment>) -> some View {
        AnyView(
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 20) {
                    Text(comment.wrappedValue.by)
                    Text(comment.wrappedValue.timeAgo)
                }
                .foregroundStyle(.gray)
                
                Text(comment.wrappedValue.text)
                
                if !comment.wrappedValue.kids.isEmpty {
                    Button(action: {
                        print("tapped to view comments of comment id \(comment.wrappedValue.id)")
                        comment.wrappedValue.showKidComments.toggle()

                    }, label: {
                        Text(comment.wrappedValue.showKidComments ? "Hide Comments" : "View Comments")
                            .foregroundStyle(.orange)
                    })
                }
                if comment.wrappedValue.showKidComments {
                    VStack(alignment: .leading, spacing: 10) {
                        if comment.kidComments.isEmpty {
                            ProgressView("Loading comments...")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                .onAppear {
                                Task {
                                    comment.wrappedValue.kidComments = await viewModel.getComments(ids: comment.wrappedValue.kids)
                                }
                            }
                        } else {
                            ForEach(comment.wrappedValue.kidComments.indices, id: \.self) { index in
                                let kidComment = comment.wrappedValue.kidComments[index]
                                createCommentSection(comment: Binding(
                                    get: { kidComment },
                                    set: { comment.wrappedValue.kidComments[index] = $0 }
                                ))
                            }
                        }
                    }
                }
                
            }
                .padding()
                .border(width: 1, edges: [.leading], color: .orange)
        )
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if comments.isEmpty {
                ProgressView("Loading comments...")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            } else {
                ForEach($comments, id: \.id) { $comment in
                    createCommentSection(comment: $comment)
                }
            }
        }
        .onAppear {
            Task {
                comments = await viewModel.getComments(ids: commentIds)
            }
        }
    }
}
