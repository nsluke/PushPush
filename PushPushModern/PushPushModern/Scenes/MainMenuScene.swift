import SpriteKit

final class MainMenuScene: SKScene {

    // Decorative lines
    private var topLines: [SKSpriteNode] = []
    private var bottomLines: [SKSpriteNode] = []

    // Buttons
    private let onePlayerButton = SKLabelNode(text: "1 PLAYER")
    private let twoPlayerButton = SKLabelNode(text: "2 PLAYER")
    private let colorsButton = SKLabelNode(text: "COLORS")
    private let tutorialButton = SKLabelNode(text: "TUTORIAL")
    private let moreGamesButton = SKLabelNode(text: "MORE GAMES")

    private let titleTop = SKLabelNode(text: "PUSH")
    private let titleBottom = SKLabelNode(text: "PUSH")

    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupDecorativeLines()
        setupTitles()
        setupButtons()
    }

    // MARK: - Layout

    private func setupDecorativeLines() {
        let state = GameState.shared
        let colWidth = size.width / 3
        let lineW = max(1, colWidth - Constants.linePadding * 2)

        // Top decorative lines (P2 color) — near top of screen
        for i in 0..<3 {
            let line = SKSpriteNode(color: state.p2Color, size: CGSize(width: lineW, height: Constants.lineHeight))
            line.position = CGPoint(x: colWidth * CGFloat(i) + colWidth / 2, y: size.height - 60)
            addChild(line)
            topLines.append(line)
        }

        // Bottom decorative lines (P1 color) — near bottom
        for i in 0..<3 {
            let line = SKSpriteNode(color: state.p1Color, size: CGSize(width: lineW, height: Constants.lineHeight))
            line.position = CGPoint(x: colWidth * CGFloat(i) + colWidth / 2, y: 60)
            addChild(line)
            bottomLines.append(line)
        }
    }

    private func setupTitles() {
        let state = GameState.shared

        titleTop.fontName = Constants.fontName
        titleTop.fontSize = Constants.titleFontSize
        titleTop.fontColor = state.p2Color
        titleTop.position = CGPoint(x: size.width / 2, y: size.height - 120)
        addChild(titleTop)

        titleBottom.fontName = Constants.fontName
        titleBottom.fontSize = Constants.titleFontSize
        titleBottom.fontColor = state.p1Color
        titleBottom.position = CGPoint(x: size.width / 2, y: 100)
        addChild(titleBottom)
    }

    private func setupButtons() {
        let buttons: [(SKLabelNode, String)] = [
            (onePlayerButton, "onePlayer"),
            (twoPlayerButton, "twoPlayer"),
            (colorsButton, "colors"),
            (tutorialButton, "tutorial"),
            (moreGamesButton, "moreGames"),
        ]

        let centerX = size.width / 2
        let startY = size.height / 2 + 80
        let spacing: CGFloat = 50

        for (i, (label, nodeName)) in buttons.enumerated() {
            label.fontName = Constants.fontName
            label.fontSize = Constants.buttonFontSize
            label.fontColor = .white
            label.name = nodeName
            label.position = CGPoint(x: centerX, y: startY - CGFloat(i) * spacing)
            label.verticalAlignmentMode = .center
            addChild(label)
        }
    }

    // MARK: - Touch

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tapped = atPoint(location)

        switch tapped.name ?? tapped.parent?.name {
        case "onePlayer":
            GameState.shared.gameMode = .onePlayer
            GameState.shared.resetForNewGame()
            transition(to: CountdownScene(size: size))

        case "twoPlayer":
            GameState.shared.gameMode = .twoPlayer
            GameState.shared.resetForNewGame()
            transition(to: CountdownScene(size: size))

        case "colors":
            transition(to: ColorSelectScene(size: size))

        case "tutorial":
            transition(to: TutorialScene(size: size))

        case "moreGames":
            moreGamesButton.text = "COMING SOON!"
            moreGamesButton.run(SKAction.sequence([
                SKAction.wait(forDuration: 1.5),
                SKAction.run { [weak self] in self?.moreGamesButton.text = "MORE GAMES" }
            ]))

        default:
            break
        }
    }

    private func transition(to scene: SKScene) {
        scene.scaleMode = .resizeFill
        view?.presentScene(scene, transition: .fade(withDuration: 0.4))
    }
}
