import WidgetKit
import SwiftUI
import HackNewsShared

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), story: Story.placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), story: Story.placeholder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let stories = try await StoryService.shared.fetchTopStories(count: 1)
                if let story = stories.first {
                    let entry = SimpleEntry(date: Date(), story: story)
                    let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
                    let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                    completion(timeline)
                }
            } catch {
                let entry = SimpleEntry(date: Date(), story: Story.placeholder)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(15 * 60)))
                completion(timeline)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let story: Story
}

struct HackNewsWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Latest from HN")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(entry.story.title)
                .font(.headline)
                .lineLimit(2)
            
            if let score = entry.story.score {
                HStack {
                    Image(systemName: "arrow.up")
                    Text("\(score)")
                }
                .font(.caption)
                .foregroundColor(.orange)
            }
        }
        .padding()
    }
}

struct HackNewsWidget: Widget {
    let kind: String = "HackNewsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HackNewsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("HackNews Latest")
        .description("Display the latest story from Hacker News.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    HackNewsWidget()
} timeline: {
    SimpleEntry(date: .now, story: .placeholder)
} 