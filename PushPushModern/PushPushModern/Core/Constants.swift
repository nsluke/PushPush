import SpriteKit

enum Constants {
    // MARK: - Gameplay
    static let moveDistance: CGFloat = 20.0
    static let tickInterval: TimeInterval = 0.3
    static let maxTouchesPerZone = 2

    // MARK: - Layout
    static let lineHeight: CGFloat = 4.0
    static let linePadding: CGFloat = 2.0

    static func columnBounds(screenWidth sw: CGFloat) -> (left: CGFloat, right: CGFloat) {
        (sw / 3.0, sw * 2.0 / 3.0)
    }

    static func rowBoundary(screenHeight sh: CGFloat) -> CGFloat {
        sh / 2.0
    }

    // MARK: - Colors
    struct PlayerColor {
        let name: String
        let color: SKColor
    }

    static let playerColors: [PlayerColor] = [
        PlayerColor(name: "Black",  color: SKColor(red: 0, green: 0, blue: 0, alpha: 1)),
        PlayerColor(name: "Violet", color: SKColor(red: 127/255, green: 0, blue: 127/255, alpha: 1)),
        PlayerColor(name: "Indigo", color: SKColor(red: 0, green: 0, blue: 1, alpha: 1)),
        PlayerColor(name: "Blue",   color: SKColor(red: 0, green: 1, blue: 1, alpha: 1)),
        PlayerColor(name: "Green",  color: SKColor(red: 0, green: 1, blue: 0, alpha: 1)),
        PlayerColor(name: "Yellow", color: SKColor(red: 1, green: 1, blue: 0, alpha: 1)),
        PlayerColor(name: "Orange", color: SKColor(red: 1, green: 165/255, blue: 0, alpha: 1)),
        PlayerColor(name: "Red",    color: SKColor(red: 1, green: 0, blue: 0, alpha: 1)),
        PlayerColor(name: "White",  color: .white),
    ]

    static let defaultP1Color: SKColor = .white
    static let defaultP2Color = SKColor(red: 127/255, green: 0, blue: 127/255, alpha: 1)

    // MARK: - Game Modes
    enum GameMode: Int {
        case none = 0
        case onePlayer = 1
        case twoPlayer = 2
    }

    // MARK: - Persistence
    static let highScoreKey = "onePlayerHighScore"

    // MARK: - Audio
    static let soundTouch = "Blip_Select46.mp3"
    static let soundGameOver = "Randomize6.mp3"
    static let soundGameStart = "Randomize7.mp3"

    // MARK: - Fonts
    static let fontName = "AvenirNext-Bold"
    static let titleFontSize: CGFloat = 48
    static let buttonFontSize: CGFloat = 24
    static let scoreFontSize: CGFloat = 36
    static let countdownFontSize: CGFloat = 72
}
