//
//  HackNewsWidgetLiveActivity.swift
//  HackNewsWidget
//
//  Created by Omer Cagri Sayir on 8.04.2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HackNewsWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HackNewsWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HackNewsWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension HackNewsWidgetAttributes {
    fileprivate static var preview: HackNewsWidgetAttributes {
        HackNewsWidgetAttributes(name: "World")
    }
}

extension HackNewsWidgetAttributes.ContentState {
    fileprivate static var smiley: HackNewsWidgetAttributes.ContentState {
        HackNewsWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HackNewsWidgetAttributes.ContentState {
         HackNewsWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HackNewsWidgetAttributes.preview) {
   HackNewsWidgetLiveActivity()
} contentStates: {
    HackNewsWidgetAttributes.ContentState.smiley
    HackNewsWidgetAttributes.ContentState.starEyes
}
