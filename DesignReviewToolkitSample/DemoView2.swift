//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI

// MARK: - Model

struct Game: Identifiable, Equatable {
  let id = UUID()
  let title: String
  let genre: String
  let platform: String
  let shortDescription: String
  let rating: Int // 1–5
}

// MARK: - Main View

public struct DemoView2: View {
  
  public init() {}
  
  @State private var games: [Game] = [
    Game(
      title: "The Legend of Zelda: Breath of the Wild",
      genre: "Action-Adventure",
      platform: "Nintendo Switch",
      shortDescription: "Explore a vast open world, solve shrines, and defeat Calamity Ganon.",
      rating: 5
    )
  ]
  
  @State private var dragOffset: CGSize = .zero
  @State private var isLiking: Bool = false
  @State private var isSkipping: Bool = false
  
  private let swipeThreshold: CGFloat = 120
  
  public var body: some View {
    VStack(spacing: 24) {
      ZStack {
        ForEach(games) { game in
          let isTop = game == games.first
          
          GameCard(game: game)
            .offset(isTop ? dragOffset : .zero)
            .scaleEffect(isTop ? 1.0 : 0.95)
            .rotationEffect(isTop ? .degrees(Double(dragOffset.width / 15)) : .degrees(0))
            .opacity(isTop ? 1.0 : 0.7)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: dragOffset)
            .accessibilityHidden(!isTop)
            .zIndex(isTop ? 1 : 0)
        }
        
        if games.isEmpty {
          NoMoreGamesView()
        }
      }
      .frame(maxHeight: .infinity)
      .padding(.horizontal)

      // Accessible button alternatives to swiping
      if let _ = games.first {
        HStack(spacing: 40) {
          Button(action: { }) {
            VStack {
              Image(systemName: "xmark.circle.fill")
                .font(.system(size: 40))

              Text("Skip")
              
            }
            
          }
          .accessibilityLabel("Skip game")
          .accessibilityHint("Reject this game and move to the next one.")

          Button(action: { }) {
            VStack {
              Image(systemName: "heart.circle.fill")
                .font(.system(size: 40))

              Text("Like")
              
            }
            
          }
          .accessibilityLabel("Like game")
          .accessibilityHint("Like this game and move to the next one.")

        }
        .font(.headline)
        .padding(.bottom)

      } else {
        Button("Reset Deck") { }
          .padding(.bottom)
          .accessibilityHint("Reload the list of games to swipe through again.")

      }
    }
    .navigationTitle("Games")
    .navigationBarTitleDisplayMode(.inline)
    .background(Color(uiColor: .systemBackground))

  }
  
}

// MARK: - Card View

struct GameCard: View {
  let game: Game
  @Environment(\.dynamicTypeSize) private var dynamicTypeSize
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      // Placeholder image / banner area
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .fill(.green.opacity(0.7))
        .overlay(
          Image(systemName: "gamecontroller.fill")
            .font(.system(size: 40))
            .opacity(0.5)

        )
        .frame(height: 180)
        .accessibilityHidden(true) // purely decorative

      VStack(alignment: .leading, spacing: 8) {
        Text(game.title)
          .font(.title2.bold())
          .fixedSize(horizontal: false, vertical: true)

        Text("\(game.genre) • \(game.platform)")
          .font(.subheadline)
          .foregroundStyle(.secondary)
          .fixedSize(horizontal: false, vertical: true)

        Text(game.shortDescription)
          .font(.body)
          .foregroundStyle(.primary)
          .fixedSize(horizontal: false, vertical: true)
          .lineLimit(dynamicTypeSize.isAccessibilitySize ? nil : 3)

        HStack(spacing: 4) {
          ForEach(0..<5) { index in
            Image(systemName: index < game.rating ? "star.fill" : "star")
              .imageScale(.small)

          }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rated \(game.rating) out of 5 stars.")

      }
      .padding(.horizontal)
      .padding(.bottom)

    }
    
    .background(
      RoundedRectangle(cornerRadius: 24, style: .continuous)
        .fill(Color(uiColor: .secondarySystemBackground))
        .shadow(radius: 6, y: 4)

    )
    .padding(.vertical, 8)
    .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    
    // Expose as a single accessible element (like a Tinder card)
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("\(game.title), \(game.genre) on \(game.platform). \(game.shortDescription). Rated \(game.rating) out of 5 stars.")
    .accessibilityHint("Swipe right to like, swipe left to skip, or use the Like and Skip buttons below.")
    .accessibilityAddTraits(.isButton)

  }
  
}

// MARK: - Helper Views

struct TagLabel: View {
  let text: String
  
  var body: some View {
    Text(text)
      .font(.headline.weight(.bold))
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .background(text == "LIKE" ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
      .foregroundColor(.white)
      .clipShape(Capsule())

  }
  
}

struct NoMoreGamesView: View {
  var body: some View {
    VStack(spacing: 8) {
      Image(systemName: "checkmark.seal.fill")
        .font(.system(size: 40))

      Text("No more games")
        .font(.headline)

      Text("You've reached the end of the deck.")
        .font(.subheadline)
        .foregroundStyle(.secondary)

    }
    .padding()
    .accessibilityElement(children: .combine)
    .accessibilityLabel("No more games. You've reached the end of the deck.")

  }
}

#Preview {
  DemoView2()
}
