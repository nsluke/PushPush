import SpriteKit

final class CountdownScene: SKScene {

    private let countdownLabel = SKLabelNode(text: "")

    override func didMove(to view: SKView) {
        backgroundColor = .black
        let state = GameState.shared

        if state.gameMode == .twoPlayer {
            setupTwoPlayerLabels(state: state)
        } else {
            setupOnePlayerLabel(state: state)
        }

        setupCountdownLabel()
        runCountdown()
    }

    // MARK: - Setup

    private func setupOnePlayerLabel(state: GameState) {
        let ready = SKLabelNode(text: "Get Ready...")
        ready.fontName = Constants.fontName
        ready.fontSize = 28
        ready.fontColor = state.p1Color
        ready.position = CGPoint(x: size.width / 2, y: size.height / 2 + 80)
        addChild(ready)
    }

    private func setupTwoPlayerLabels(state: GameState) {
        // Player 2 (top)
        let p2Label = SKLabelNode(text: "PLAYER 2")
        p2Label.fontName = Constants.fontName
        p2Label.fontSize = 22
        p2Label.fontColor = state.p2Color
        p2Label.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        addChild(p2Label)

        // Down arrow for P2
        let p2Arrow = SKLabelNode(text: "▼")
        p2Arrow.fontName = Constants.fontName
        p2Arrow.fontSize = 28
        p2Arrow.fontColor = state.p2Color
        p2Arrow.position = CGPoint(x: size.width / 2, y: size.height * 0.75 - 35)
        addChild(p2Arrow)

        // Player 1 (bottom)
        let p1Label = SKLabelNode(text: "PLAYER 1")
        p1Label.fontName = Constants.fontName
        p1Label.fontSize = 22
        p1Label.fontColor = state.p1Color
        p1Label.position = CGPoint(x: size.width / 2, y: size.height * 0.25)
        addChild(p1Label)

        // Up arrow for P1
        let p1Arrow = SKLabelNode(text: "▲")
        p1Arrow.fontName = Constants.fontName
        p1Arrow.fontSize = 28
        p1Arrow.fontColor = state.p1Color
        p1Arrow.position = CGPoint(x: size.width / 2, y: size.height * 0.25 + 35)
        addChild(p1Arrow)
    }

    private func setupCountdownLabel() {
        countdownLabel.fontName = Constants.fontName
        countdownLabel.fontSize = Constants.countdownFontSize
        countdownLabel.fontColor = .white
        countdownLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        countdownLabel.verticalAlignmentMode = .center
        addChild(countdownLabel)
    }

    // MARK: - Countdown

    private func runCountdown() {
        let sequence = SKAction.sequence([
            SKAction.run { [weak self] in self?.countdownLabel.text = "3" },
            SKAction.wait(forDuration: 0.8),
            SKAction.run { [weak self] in self?.countdownLabel.text = "2" },
            SKAction.wait(forDuration: 0.8),
            SKAction.run { [weak self] in self?.countdownLabel.text = "1" },
            SKAction.wait(forDuration: 0.8),
            SKAction.run { [weak self] in
                self?.countdownLabel.text = "GO!"
                AudioManager.shared.play(Constants.soundGameStart, on: self ?? SKNode())
            },
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in self?.transitionToGameplay() },
        ])
        run(sequence)
    }

    private func transitionToGameplay() {
        let state = GameState.shared
        let scene: SKScene
        switch state.gameMode {
        case .onePlayer:
            scene = OnePlayerScene(size: size)
        case .twoPlayer:
            scene = TwoPlayerScene(size: size)
        case .none:
            scene = MainMenuScene(size: size)
        }
        scene.scaleMode = .resizeFill
        view?.presentScene(scene, transition: .fade(withDuration: 0.3))
    }
}
