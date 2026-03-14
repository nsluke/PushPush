import SpriteKit

final class GameState {
    static let shared = GameState()
    private init() {}

    var p1Score: Int = 0
    var p2Score: Int = 0
    var onePlayerHighScore: Int = 0
    var gameMode: Constants.GameMode = .none
    var winner: Int = 0

    var p1Color: SKColor = Constants.defaultP1Color
    var p2Color: SKColor = Constants.defaultP2Color

    var persistedHighScore: Int {
        get { UserDefaults.standard.integer(forKey: Constants.highScoreKey) }
        set { UserDefaults.standard.set(newValue, forKey: Constants.highScoreKey) }
    }

    func resetScores() {
        p1Score = 0
        p2Score = 0
        onePlayerHighScore = 0
        winner = 0
    }

    func resetForNewGame() {
        onePlayerHighScore = 0
        winner = 0
    }
}
