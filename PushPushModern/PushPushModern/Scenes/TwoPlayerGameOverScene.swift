import SpriteKit

final class TwoPlayerGameOverScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .black

        let state = GameState.shared
        setupLabels(state: state)
        setupButtons()
        setupCelebrationParticle(state: state)

        AudioManager.shared.play(Constants.soundGameOver, on: self)
    }

    // MARK: - Setup

    private func setupLabels(state: GameState) {
        let centerX = size.width / 2

        // Player 2 area (top half, text upside down for P2's perspective)
        let p2Status = SKLabelNode(text: state.winner == 2 ? "YOU WON!" : "YOU LOST")
        p2Status.fontName = Constants.fontName
        p2Status.fontSize = 28
        p2Status.fontColor = state.p2Color
        p2Status.position = CGPoint(x: centerX, y: size.height * 0.75 + 30)
        p2Status.zRotation = .pi
        addChild(p2Status)

        let p2Score = SKLabelNode(text: "\(state.p2Score)")
        p2Score.fontName = Constants.fontName
        p2Score.fontSize = Constants.titleFontSize
        p2Score.fontColor = state.p2Color
        p2Score.position = CGPoint(x: centerX, y: size.height * 0.75 - 20)
        p2Score.zRotation = .pi
        addChild(p2Score)

        // Divider
        let divider = SKSpriteNode(color: .gray, size: CGSize(width: size.width * 0.8, height: 1))
        divider.position = CGPoint(x: centerX, y: size.height / 2)
        addChild(divider)

        // Player 1 area (bottom half)
        let p1Status = SKLabelNode(text: state.winner == 1 ? "YOU WON!" : "YOU LOST")
        p1Status.fontName = Constants.fontName
        p1Status.fontSize = 28
        p1Status.fontColor = state.p1Color
        p1Status.position = CGPoint(x: centerX, y: size.height * 0.25 - 30)
        addChild(p1Status)

        let p1Score = SKLabelNode(text: "\(state.p1Score)")
        p1Score.fontName = Constants.fontName
        p1Score.fontSize = Constants.titleFontSize
        p1Score.fontColor = state.p1Color
        p1Score.position = CGPoint(x: centerX, y: size.height * 0.25 + 20)
        addChild(p1Score)
    }

    private func setupButtons() {
        let centerX = size.width / 2

        let rematch = SKLabelNode(text: "REMATCH")
        rematch.fontName = Constants.fontName
        rematch.fontSize = Constants.buttonFontSize
        rematch.fontColor = .white
        rematch.name = "rematch"
        rematch.position = CGPoint(x: centerX, y: size.height / 2 + 30)
        rematch.verticalAlignmentMode = .center
        addChild(rematch)

        let mainMenu = SKLabelNode(text: "MAIN MENU")
        mainMenu.fontName = Constants.fontName
        mainMenu.fontSize = Constants.buttonFontSize
        mainMenu.fontColor = .white
        mainMenu.name = "mainMenu"
        mainMenu.position = CGPoint(x: centerX, y: size.height / 2 - 20)
        mainMenu.verticalAlignmentMode = .center
        addChild(mainMenu)
    }

    private func setupCelebrationParticle(state: GameState) {
        let winnerColor = state.winner == 1 ? state.p1Color : state.p2Color
        let yPos = state.winner == 1 ? size.height * 0.25 : size.height * 0.75

        let emitter = SKEmitterNode()
        emitter.particleBirthRate = 60
        emitter.numParticlesToEmit = 150
        emitter.particleLifetime = 2.0
        emitter.particleLifetimeRange = 1.0
        emitter.particleSpeed = 80
        emitter.particleSpeedRange = 40
        emitter.emissionAngleRange = .pi * 2
        emitter.particleScale = 0.05
        emitter.particleScaleRange = 0.03
        emitter.particleAlphaSpeed = -0.5
        emitter.particleColor = winnerColor
        emitter.particleColorBlendFactor = 1.0
        emitter.particleBlendMode = .add
        emitter.position = CGPoint(x: size.width / 2, y: yPos)
        addChild(emitter)
    }

    // MARK: - Touch

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tapped = atPoint(location)

        switch tapped.name {
        case "rematch":
            GameState.shared.gameMode = .twoPlayer
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
}
