//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI

// MARK: - Models (in the same file for convenience)

struct Article: Identifiable {
  let id = UUID()
  let title: String
  let subtitle: String
  let category: String
  let timeAgo: String
  let isTopStory: Bool
}

// MARK: - Main View

public struct DemoView1: View {
  
  public init() {}
  
  // Sample data – replace with your real data source
  private let articles: [Article] = [
    Article(
      title: "Designing Calm Technology for Everyday Life",
      subtitle: "How subtle interactions can make our devices feel less demanding.",
      category: "FEATURED",
      timeAgo: "10 min read",
      isTopStory: true
    ),
    Article(
      title: "SwiftUI in Production",
      subtitle: "Lessons from building large apps using a declarative UI.",
      category: "DEVELOPMENT",
      timeAgo: "5 min read",
      isTopStory: false
    ),
    Article(
      title: "The Future of Spatial Computing",
      subtitle: "Why AR-first design is changing everyday workflows.",
      category: "AR & VR",
      timeAgo: "8 min read",
      isTopStory: false
    ),
    Article(
      title: "Accessibility-First Product Design",
      subtitle: "Designing for everyone from day one pays off for everyone.",
      category: "ACCESSIBILITY",
      timeAgo: "6 min read",
      isTopStory: false
    )
  ]
  
  public var body: some View {
    
    VStack(alignment: .leading, spacing: 24) {
      if let topStory = articles.first(where: { $0.isTopStory }) {
        TopStoryCard(article: topStory)
          .accessibilitySortPriority(2)
      }
      
      Text("Today")
        .font(.title.bold())
        .padding(.horizontal)
        .accessibilityAddTraits(.isHeader)

      VStack(spacing: 0) {
        ForEach(articles.filter { !$0.isTopStory }) { article in
          ArticleRow(article: article)
            .accessibilitySortPriority(1)
          
          Divider()
            .accessibilityHidden(true)
        }
      }
      .background(.background)
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
      .padding(.horizontal)

    }
    .padding(.vertical)

  }
}

// MARK: - Top Story Card

struct TopStoryCard: View {
  let article: Article
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      // Decorative background (image placeholder)
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(.blue.opacity(0.8))
        .overlay(
          LinearGradient(
            colors: [.black.opacity(0.6), .clear],
            startPoint: .bottom,
            endPoint: .center
          )
        )
        .accessibilityHidden(true) // decorative

      VStack(alignment: .leading, spacing: 8) {
        Text(article.category)
          .font(.caption.weight(.semibold))
          .textCase(.uppercase)
          .padding(.horizontal, 10)
          .padding(.vertical, 4)
          .background(.ultraThinMaterial)
          .clipShape(Capsule())
          .accessibilityLabel(article.category)

        Text(article.title)
          .font(.system(dynamicTypeSize.isAccessibilitySize ? .title2 : .title, design: .default).bold())
          .fixedSize(horizontal: false, vertical: true)

        Text(article.subtitle)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 2)

        Text(article.timeAgo)
          .font(.caption)
          .foregroundStyle(.secondary)
          .padding(.top, 4)

      }
      
      .foregroundColor(.white)
      .padding()

    }
    .frame(maxWidth: .infinity, minHeight: 260, maxHeight: 360)
    .padding(.horizontal)
    .contentShape(Rectangle())
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("\(article.category), \(article.title). \(article.subtitle). \(article.timeAgo). Top story.")
    .accessibilityHint("Double-tap to open this top story.")
    .accessibilityAddTraits(.isButton)

  }
}

// MARK: - Article Row

struct ArticleRow: View {
  let article: Article
  
  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      
      RoundedRectangle(cornerRadius: 12, style: .continuous)
        .fill(.gray.opacity(0.2))
        .frame(width: 80, height: 80)
        .accessibilityHidden(true) // decorative

      VStack(alignment: .leading, spacing: 4) {
        Text(article.category)
          .font(.caption.weight(.semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
          .accessibilityLabel(article.category)

        Text(article.title)
          .font(.headline)
          .fixedSize(horizontal: false, vertical: true)

        Text(article.subtitle)
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .lineLimit(2)

        Text(article.timeAgo)
          .font(.caption)
          .foregroundStyle(.secondary)
          .padding(.top, 2)

      }
      
      Spacer(minLength: 0)
    }
    .padding(16)
    .contentShape(Rectangle())
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("\(article.category). \(article.title). \(article.subtitle). \(article.timeAgo).")
    .accessibilityHint("Double-tap to open this article.")
    .accessibilityAddTraits(.isButton)

  }
}

#Preview {
  DemoView1()
}
