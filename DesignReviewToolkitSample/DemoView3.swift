import DesignReviewToolkit // Dynamic
//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI
import AVKit

// MARK: - Model

struct ShortVideo {
  let title: String
  let creatorName: String
  let creatorHandle: String
  let isSubscribed: Bool
  let likeCount: Int
  let commentCount: Int
  let shareCount: Int
  let url: URL
}

// MARK: - Main View

public struct DemoView3: View {
  
  public init() {}
  
  // Replace this with your own video model / data source
  private let video = ShortVideo(
    title: "Figma Glass effect buttons",
    creatorName: "FigmaKing",
    creatorHandle: "@FigmaKing",
    isSubscribed: false,
    likeCount: 75000,
    commentCount: 194,
    shareCount: 1200,
    url: URL(string: "https://video.m3u8")!
  )
  
  @State private var player: AVPlayer? = nil
  @State private var isPlaying = true
  @State private var isMuted = false
  @State private var isLiked = false
  @State private var isDisliked = false
  @State private var isSubscribed = false
  
  public var body: some View {
    ZStack {
      Color.gray
      
      // Overlays
      VStack {
        topBar
        Spacer()
        sideActions
        bottomInfoBar
      }
      .padding(.horizontal, 8)
      .padding(.bottom, 8)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.padding: "8"], depth: 1))


    }

  }
  
  // MARK: - Overlays
  
  public var topBar: some View {
    HStack {
      Button {
        // Handle back navigation in your container
      } label: {
        Image(systemName: "chevron.left")
          .font(.title2.weight(.semibold))
          .padding(8)
          .background(.black.opacity(0.4))
          .clipShape(Circle())
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".title2.weight(.semibold)", DesignReviewToolkit.StyleType.padding: "8", DesignReviewToolkit.StyleType.background: ".black.opacity(0.4)"], depth: 2))


      }
      .accessibilityLabel("Back")
      .accessibilityHint("Go back to the previous screen.")
      .accessibilitySortPriority(1)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilitySortPriority: "1", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Back\"", DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Go back to the previous screen.\""], style: [:], depth: 1))


      Spacer()
      
      Button {
        // search
      } label: {
        Image(systemName: "magnifyingglass")
          .font(.title2)
          .padding(8)
          .background(.black.opacity(0.4))
          .clipShape(Circle())
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".title2", DesignReviewToolkit.StyleType.padding: "8", DesignReviewToolkit.StyleType.background: ".black.opacity(0.4)"], depth: 2))


      }
      .accessibilityLabel("Search")
      .accessibilitySortPriority(2)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilitySortPriority: "2", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Search\""], style: [:], depth: 1))


      Button {
        // more
      } label: {
        Image(systemName: "ellipsis")
          .rotationEffect(.degrees(90))
          .font(.title2)
          .padding(8)
          .background(.black.opacity(0.4))
          .clipShape(Circle())
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.background: ".black.opacity(0.4)", DesignReviewToolkit.StyleType.font: ".title2", DesignReviewToolkit.StyleType.padding: "8"], depth: 2))


      }
      .accessibilityLabel("More options")
      .accessibilitySortPriority(3)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilitySortPriority: "3", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"More options\""], style: [:], depth: 1))


    }
    .foregroundColor(.white)
    .padding(.top, 12)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.padding: "12"], depth: 0))


  }
  
  private var sideActions: some View {
    HStack(alignment: .bottom) {
      Spacer()
      
      VStack(spacing: 18) {
        likeButton
        dislikeButton
        commentsButton
        shareButton
        rotateButton
      }
      .foregroundColor(.white)
      .padding(.trailing, 4)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.padding: "4"], depth: 1))


    }
  }
  
  private var likeButton: some View {
    Button {
      isLiked.toggle()
      if isLiked { isDisliked = false }
    } label: {
      VStack(spacing: 4) {
        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
          .font(.system(size: 28))
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".system(size: 28)"], depth: 2))


        Text("\(video.likeCount.formatted())")
          .font(.caption)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "\"\\(video.likeCount.formatted())\""], style: [DesignReviewToolkit.StyleType.font: ".caption"], depth: 2))


      }
    }
    .accessibilityLabel("Like video")
    .accessibilityValue(isLiked ? "On" : "Off")
    .accessibilityHint("Double-tap to toggle like.")
    .accessibilitySortPriority(1)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityValue: "isLiked ? \"On\" : \"Off\"", DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Double-tap to toggle like.\"", DesignReviewToolkit.AccessibilityType.accessibilitySortPriority: "1", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Like video\""], style: [:], depth: 0))


  }
  
  private var dislikeButton: some View {
    Button {
      isDisliked.toggle()
      if isDisliked { isLiked = false }
    } label: {
      VStack(spacing: 4) {
        Image(systemName: isDisliked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
          .font(.system(size: 28))
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".system(size: 28)"], depth: 2))


        Text("Dislike")
          .font(.caption)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "\"Dislike\""], style: [DesignReviewToolkit.StyleType.font: ".caption"], depth: 2))


      }
    }
    .accessibilityLabel("Dislike video")
    .accessibilityValue(isDisliked ? "On" : "Off")
    .accessibilityHint("Double-tap to toggle dislike.")
    .accessibilitySortPriority(2)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilitySortPriority: "2", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Dislike video\"", DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Double-tap to toggle dislike.\"", DesignReviewToolkit.AccessibilityType.accessibilityValue: "isDisliked ? \"On\" : \"Off\""], style: [:], depth: 0))


  }
  
  private var commentsButton: some View {
    Button {
      // open comments sheet
    } label: {
      VStack(spacing: 4) {
        Image(systemName: "text.bubble")
          .font(.system(size: 28))
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".system(size: 28)"], depth: 2))


        Text("\(video.commentCount)")
          .font(.caption)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "\"\\(video.commentCount)\""], style: [DesignReviewToolkit.StyleType.font: ".caption"], depth: 2))


      }
    }
    .accessibilityLabel("Comments")
    .accessibilityHint("Double-tap to open comments.")
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Comments\"", DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Double-tap to open comments.\""], style: [:], depth: 0))


  }
  
  private var shareButton: some View {
    Button {
      // share sheet
    } label: {
      VStack(spacing: 4) {
        Image(systemName: "arrowshape.turn.up.right")
          .font(.system(size: 28))
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".system(size: 28)"], depth: 2))


        Text("\(video.shareCount)")
          .font(.caption)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "\"\\(video.shareCount)\""], style: [DesignReviewToolkit.StyleType.font: ".caption"], depth: 2))


      }
    }
    .accessibilityLabel("Share video")
    .accessibilityHint("Double-tap to share this video.")
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"Share video\"", DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Double-tap to share this video.\""], style: [:], depth: 0))


  }
  
  private var rotateButton: some View {
    Button {
      // rotate / flip camera, or additional action
    } label: {
      Image(systemName: "arrow.triangle.2.circlepath.camera")
        .font(.system(size: 26))
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [:], style: [DesignReviewToolkit.StyleType.font: ".system(size: 26)"], depth: 1))


    }
    .accessibilityLabel("More camera options")
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityLabel: "\"More camera options\""], style: [:], depth: 0))


  }
  
  private var bottomInfoBar: some View {
    VStack(spacing: 8) {
      HStack(spacing: 10) {
        Circle()
          .fill(.white.opacity(0.7))
          .frame(width: 32, height: 32)
          .overlay(
            Image(systemName: "person.fill")
              .foregroundColor(.black)

          )
          .accessibilityHidden(true)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityHidden: "true"], style: [DesignReviewToolkit.StyleType.fill: ".white.opacity(0.7)"], depth: 2))


        VStack(alignment: .leading, spacing: 2) {
          Text(video.creatorHandle)
            .font(.subheadline.bold())
            .font(.caption)
            .foregroundStyle(.secondary)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "video.creatorHandle"], style: [DesignReviewToolkit.StyleType.font: ".caption", DesignReviewToolkit.StyleType.foregroundStyle: ".secondary"], depth: 3))


        }
        
        Spacer()
        
        Button {
          isSubscribed.toggle()
        } label: {
          Text(isSubscribed ? "Subscribed" : "Subscribe")
            .font(.subheadline.bold())
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(isSubscribed ? .gray.opacity(0.6) : .white)
            .foregroundColor(isSubscribed ? .white : .black)
            .clipShape(Capsule())
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "isSubscribed ? \"Subscribed\" : \"Subscribe\""], style: [DesignReviewToolkit.StyleType.padding: "6", DesignReviewToolkit.StyleType.background: "isSubscribed ? .gray.opacity(0.6) : .white", DesignReviewToolkit.StyleType.font: ".subheadline.bold()"], depth: 3))


        }
        .accessibilityLabel(isSubscribed ? "Subscribed to \(video.creatorName)" : "Subscribe to \(video.creatorName)")
        .accessibilityHint("Double-tap to toggle subscription.")
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityHint: "\"Double-tap to toggle subscription.\"", DesignReviewToolkit.AccessibilityType.accessibilityLabel: "isSubscribed ? \"Subscribed to \\(video.creatorName)\" : \"Subscribe to \\(video.creatorName)\""], style: [:], depth: 2))


      }
      
      VStack(alignment: .leading, spacing: 2) {
        Text(video.title)
          .font(.subheadline)
          .lineLimit(2)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "video.title"], style: [DesignReviewToolkit.StyleType.font: ".subheadline"], depth: 2))


        Text("How to create re-usable glass effect components")
          .font(.caption)
          .foregroundStyle(.secondary)
          .lineLimit(1)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.text: "\"How to create re-usable glass effect components\""], style: [DesignReviewToolkit.StyleType.foregroundStyle: ".secondary", DesignReviewToolkit.StyleType.font: ".caption"], depth: 2))


      }
      .frame(maxWidth: .infinity, alignment: .leading)

      // Simple progress bar
      GeometryReader { proxy in
        ZStack(alignment: .leading) {
          Capsule()
            .fill(.white.opacity(0.3))
          Capsule()
            .fill(.white)
            .frame(width: proxy.size.width * 0.3) // fake 30% progress
            .accessibilityHidden(true)
        }
      }
      .frame(height: 3)
      .accessibilityLabel("Video progress 30 percent.")
    }
    .padding(.horizontal, 8)
    .padding(.bottom, 4)
    .foregroundColor(.white)
    .background(
      LinearGradient(
        colors: [Color.black.opacity(0.6), .clear],
        startPoint: .bottom,
        endPoint: .top
      )
      .ignoresSafeArea(edges: .bottom)
    )
    .accessibilityElement(children: .contain)
.modifier(DesignReviewToolkit.CustomAccessibilityModifier(accessibility: [DesignReviewToolkit.AccessibilityType.accessibilityElement: ".contain"], style: [DesignReviewToolkit.StyleType.padding: "4", DesignReviewToolkit.StyleType.background: "LinearGradient(\n        colors: [Color.black.opacity(0.6), .clear],\n        startPoint: .bottom,\n        endPoint: .top\n      )\n      .ignoresSafeArea(edges: .bottom)"], depth: 0))


  }
  
}

#Preview {
  DemoView3()
}
