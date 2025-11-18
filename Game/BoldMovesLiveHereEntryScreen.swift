import Foundation
import SwiftUI

struct BoldMovesLiveHereEntryScreen: View {
  @StateObject private var loader: BoldMovesLiveHereWebLoader

  init(loader: BoldMovesLiveHereWebLoader) {
    _loader = StateObject(wrappedValue: loader)
  }

  var body: some View {
    ZStack {
      BoldMovesLiveHereWebViewBox(loader: loader)
        .opacity(loader.state == .finished ? 1 : 0.5)
      switch loader.state {
      case .progressing(let percent):
        BoldMovesLiveHereProgressIndicator(value: percent)
      case .failure(let err):
        BoldMovesLiveHereErrorIndicator(err: err)  // err теперь String
      case .noConnection:
        BoldMovesLiveHereOfflineIndicator()
      default:
        EmptyView()
      }
    }
  }
}

private struct BoldMovesLiveHereProgressIndicator: View {
  let value: Double
  var body: some View {
    GeometryReader { geo in
      BoldMovesLiveHereLoadingOverlay(progress: value)
        .frame(width: geo.size.width, height: geo.size.height)
        .background(Color.white)
    }
  }
}

private struct BoldMovesLiveHereErrorIndicator: View {
  let err: String  // было Error, стало String
  var body: some View {
    Text("Ошибка: \(err)").foregroundColor(.red)
  }
}

private struct BoldMovesLiveHereOfflineIndicator: View {
  var body: some View {
    Text("Нет соединения").foregroundColor(.gray)
  }
}
