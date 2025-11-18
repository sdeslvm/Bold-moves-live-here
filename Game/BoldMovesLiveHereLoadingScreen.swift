import SwiftUI

/// Loading overlay inspired by the retro hero screen while keeping the overall white shell.
struct BoldMovesLiveHereLoadingOverlay: View {
  let progress: Double
  private var progressPercentage: Int { Int(progress * 100) }

  var body: some View {
    ZStack(alignment: .bottom) {
      AnimatedGradientBackground()
        .ignoresSafeArea()

      VStack(spacing: 24) {
        Spacer(minLength: 30)

        Text("Bold Moves Loading…")
          .font(.system(size: 32, weight: .black, design: .rounded))
          .kerning(0.5)
          .multilineTextAlignment(.center)
          .overlay(
            LinearGradient(colors: [Color.pink, Color.purple, Color.blue], startPoint: .leading, endPoint: .trailing)
          )
          .mask(
            Text("Bold Moves Loading…")
              .font(.system(size: 32, weight: .black, design: .rounded))
              .kerning(0.5)
          )
          .accessibilityHidden(true)

        BoldMovesLiveHereHeroDisplay()

        BoldMovesLiveHereLoadingCard(progress: progress, progressPercentage: progressPercentage)

        Spacer(minLength: 20)
      }
      .padding(.horizontal, 32)

      BoldMovesLiveHereGroundStripe()
    }
  }
}

/// Pixelated hero pulled from the sprite sheet to mimic the in-game intro.
private struct BoldMovesLiveHereHeroDisplay: View {
  @State private var pulse = false

  var body: some View {
    ZStack {
      Circle()
        .fill(LinearGradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .frame(width: 180, height: 180)
        .blur(radius: 16)
        .scaleEffect(pulse ? 1.05 : 0.95)
        .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: pulse)

      Circle()
        .fill(LinearGradient(colors: [Color.pink.opacity(0.6), Color.orange.opacity(0.6)], startPoint: .bottomLeading, endPoint: .topTrailing))
        .frame(width: 140, height: 140)
        .offset(x: pulse ? -12 : 12, y: pulse ? 10 : -10)
        .blur(radius: 18)
        .blendMode(.screen)
        .animation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true), value: pulse)

      RoundedRectangle(cornerRadius: 28, style: .continuous)
        .strokeBorder(LinearGradient(colors: [Color.white.opacity(0.9), Color.white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
        .frame(width: 160, height: 64)
        .shadow(color: Color.white.opacity(0.25), radius: 8, y: 4)
        .overlay(
          Text("Leveling up vibes")
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
        )
        .opacity(0.9)
        .offset(y: 2)
    }
    .frame(height: 200)
    .onAppear { pulse = true }
  }
}

/// White card that contains loading text and a slim progress bar.
private struct BoldMovesLiveHereLoadingCard: View {
  let progress: Double
  let progressPercentage: Int

  var body: some View {
    VStack(spacing: 12) {
      Text("Summoning bold magic…")
        .font(.system(size: 18, weight: .semibold, design: .rounded))
        .foregroundStyle(.white)

      BoldMovesLiveHereProgressBar(progress: progress)
        .frame(height: 12)

      Text("\(progressPercentage)%").monospacedDigit()
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .foregroundStyle(.white.opacity(0.8))
    }
    .padding(.vertical, 20)
    .padding(.horizontal, 24)
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    .overlay(
      RoundedRectangle(cornerRadius: 18, style: .continuous)
        .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
    )
    .shadow(color: Color.black.opacity(0.25), radius: 20, y: 10)
  }
}

/// Simple black progress bar to fit the flat UI language.
private struct BoldMovesLiveHereProgressBar: View {
  let progress: Double

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Capsule()
          .fill(Color.white.opacity(0.15))
          .overlay(
            Capsule()
              .stroke(Color.white.opacity(0.25), lineWidth: 1)
          )

        let width = max(12, min(CGFloat(progress) * geometry.size.width, geometry.size.width))

        Capsule()
          .fill(LinearGradient(colors: [Color.cyan, Color.blue, Color.purple], startPoint: .leading, endPoint: .trailing))
          .frame(width: width)
          .shadow(color: Color.blue.opacity(0.6), radius: 8, y: 0)
          .shadow(color: Color.purple.opacity(0.4), radius: 16, y: 0)

        Circle()
          .fill(Color.white.opacity(0.9))
          .frame(width: 16, height: 16)
          .offset(x: width - 8)
          .shadow(color: Color.white.opacity(0.7), radius: 8)
      }
    }
  }
}

/// Tiled sand strip that anchors the composition and references the in-game floor texture.
private struct BoldMovesLiveHereGroundStripe: View {
  @State private var shimmer = false

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Capsule()
          .fill(Color.white.opacity(0.15))
          .frame(height: 10)
          .offset(y: 12)
          .blur(radius: 6)

        Capsule()
          .fill(LinearGradient(colors: [Color.pink, Color.purple, Color.blue], startPoint: .leading, endPoint: .trailing))
          .frame(height: 12)
          .overlay(
            Capsule()
              .stroke(Color.white.opacity(0.25), lineWidth: 1)
          )
          .mask(
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.white.opacity(0.9), Color.white.opacity(0.1)]), startPoint: shimmer ? .leading : .trailing, endPoint: shimmer ? .trailing : .leading)
          )
          .animation(.linear(duration: 1.6).repeatForever(autoreverses: true), value: shimmer)
      }
      .frame(width: geometry.size.width, alignment: .center)
    }
    .frame(height: 40)
    .onAppear { shimmer = true }
  }
}

// MARK: - Previews

#if canImport(SwiftUI)
  import SwiftUI
#endif

// Use availability to keep using the modern #Preview API on iOS 17+ and provide a fallback for older versions
@available(iOS 17.0, *)
#Preview("Vertical") {
  BoldMovesLiveHereLoadingOverlay(progress: 0.2)
}

@available(iOS 17.0, *)
#Preview("Horizontal", traits: .landscapeRight) {
  BoldMovesLiveHereLoadingOverlay(progress: 0.2)
}

// Fallback previews for iOS < 17
struct BoldMovesLiveHereLoadingOverlay_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      BoldMovesLiveHereLoadingOverlay(progress: 0.2)
        .previewDisplayName("Vertical (Legacy)")

      BoldMovesLiveHereLoadingOverlay(progress: 0.2)
        .previewDisplayName("Horizontal (Legacy)")
        .previewLayout(.fixed(width: 812, height: 375))  // Simulate landscape on older previews
    }
  }
}

private struct AnimatedGradientBackground: View {
  @State private var rotate = false

  var body: some View {
    ZStack {
      RadialGradient(colors: [Color.black, Color.indigo.opacity(0.6)], center: .center, startRadius: 50, endRadius: 500)

      AngularGradient(gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.purple.opacity(0.5), Color.blue.opacity(0.5), Color.cyan.opacity(0.5), Color.pink.opacity(0.5)]), center: .center)
        .blur(radius: 120)
        .rotationEffect(.degrees(rotate ? 360 : 0))
        .animation(.linear(duration: 18).repeatForever(autoreverses: false), value: rotate)
        .opacity(0.8)

      Circle()
        .fill(LinearGradient(colors: [Color.cyan.opacity(0.25), Color.blue.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .frame(width: 420, height: 420)
        .blur(radius: 60)
        .offset(x: -140, y: -220)

      Circle()
        .fill(LinearGradient(colors: [Color.pink.opacity(0.25), Color.purple.opacity(0.0)], startPoint: .bottomLeading, endPoint: .topTrailing))
        .frame(width: 380, height: 380)
        .blur(radius: 60)
        .offset(x: 160, y: 200)
    }
    .onAppear { rotate = true }
  }
}
