import SwiftUI

@main
struct BoldMovesLiveHereApp: App {
  @UIApplicationDelegateAdaptor(BoldMovesLiveHereAppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      BoldMovesLiveHereGameInitialView()
    }
  }
}
