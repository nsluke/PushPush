import Foundation

/// Thin analytics wrapper. Currently stubs all events.
/// To enable Firebase: add FirebaseAnalytics SPM package,
/// import FirebaseAnalytics, and replace the stub implementations.
final class AnalyticsManager {
    static let shared = AnalyticsManager()
    private init() {}

    func logEvent(_ name: String, parameters: [String: Any]? = nil) {
        // TODO: Replace with Firebase Analytics.logEvent(name, parameters: parameters)
        #if DEBUG
        if let params = parameters {
            print("[Analytics] \(name): \(params)")
        } else {
            print("[Analytics] \(name)")
        }
        #endif
    }

    func logAppOpened() {
        logEvent("app_opened")
    }

    func logStartedOnePlayer() {
        logEvent("started_one_player")
    }

    func logStartedTwoPlayer(p1Color: String, p2Color: String) {
        logEvent("started_two_player", parameters: ["p1_color": p1Color, "p2_color": p2Color])
    }

    func logOnePlayerEnded(score: Int) {
        logEvent("one_player_ended", parameters: ["score": score])
    }
}
