import SpriteKit

final class OnePlayerGameOverScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .black

        let state = GameState.shared
        let score = state.onePlayerHighScore
        let previousHigh = state.persistedHighScore
        let isNewHighScore = score > previousHigh

        if isNewHighScore {
            state.persistedHighScore = score
        }

        setupLabels(score: score, isNewHighScore: isNewHighScore, state: state)
        setupButtons()

        AudioManager.shared.play(Constants.soundGameOver, on: self)
        AnalyticsManager.shared.logOnePlayerEnded(score: score)
    }

    // MARK: - Setup

    private func setupLabels(score: Int, isNewHighScore: Bool, state: GameState) {
        let centerX = size.width / 2

        let statusLabel = SKLabelNode(text: isNewHighScore ? "NEW HIGH SCORE!" : "Your score:")
        statusLabel.fontName = Constants.fontName
        statusLabel.fontSize = 22
        statusLabel.fontColor = state.p2Color
        statusLabel.position = CGPoint(x: centerX, y: size.height / 2 + 60)
        addChild(statusLabel)

        let scoreLabel = SKLabelNode(text: "\(score)")
        scoreLabel.fontName = Constants.fontName
        scoreLabel.fontSize = Constants.titleFontSize
        scoreLabel.fontColor = state.p1Color
        scoreLabel.position = CGPoint(x: centerX, y: size.height / 2)
        addChild(scoreLabel)

        if isNewHighScore {
            // Celebration particle
            let emitter = makeCelebrationEmitter(color: state.p1Color)
            emitter.position = CGPoint(x: centerX, y: size.height / 2)
            addChild(emitter)
        }
    }

    private func setupButtons() {
        let centerX = size.width / 2

        let playAgain = SKLabelNode(text: "PLAY AGAIN")
        playAgain.fontName = Constants.fontName
        playAgain.fontSize = Constants.buttonFontSize
        playAgain.fontColor = .white
        playAgain.name = "playAgain"
        playAgain.position = CGPoint(x: centerX, y: size.height / 2 - 80)
        playAgain.verticalAlignmentMode = .center
        addChild(playAgain)

        let mainMenu = SKLabelNode(text: "MAIN MENU")
        mainMenu.fontName = Constants.fontName
        mainMenu.fontSize = Constants.buttonFontSize
        mainMenu.fontColor = .white
        mainMenu.name = "mainMenu"
        mainMenu.position = CGPoint(x: centerX, y: size.height / 2 - 130)
        mainMenu.verticalAlignmentMode = .center
        addChild(mainMenu)
    }

    // MARK: - Touch

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tapped = atPoint(location)

        switch tapped.name {
        case "playAgain":
            GameState.shared.gameMode = .onePlayer
            GameState.shared.resetForNewGame()
            let countdown = CountdownScene(size: size)
            countdown.scaleMode = .resizeFill
            view?.presentScene(countdown, transition: .fade(withDuration: 0.4))

        case "mainMenu":
            let menu = MainMenuScene(size: size)
            menu.scaleMode = .resizeFill
            view?.presentScene(menu, transition: .fade(withDuration: 0.4))

        default:
            break
        }
    }

    // MARK: - Helpers

    private func makeCelebrationEmitter(color: SKColor) -> SKEmitterNode {
        let emitter = SKEmitterNode()
        emitter.particleBirthRate = 80
        emitter.numParticlesToEmit = 200
        emitter.particleLifetime = 2.0
        emitter.particleLifetimeRange = 1.0
        emitter.particleSpeed = 100
        emitter.particleSpeedRange = 50
        emitter.emissionAngleRange = .pi * 2
        emitter.particleScale = 0.05
        emitter.particleScaleRange = 0.03
        emitter.particleAlphaSpeed = -0.5
        emitter.particleColor = color
        emitter.particleColorBlendFactor = 1.0
        emitter.particleBlendMode = .add
        return emitter
    }
}
