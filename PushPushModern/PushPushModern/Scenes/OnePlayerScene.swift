import SpriteKit

final class OnePlayerScene: SKScene {

    // MARK: - Properties

    private var linePairs: [LinePair] = []  // [left, middle, right]
    private var cornerEmitters: [SKEmitterNode] = []
    private let scoreLabel = SKLabelNode(text: "0")
    private let pauseButton = SKLabelNode(text: "⏸")
    private let resumeButton = SKLabelNode(text: "▶")

    private var bottomTouchCount = 0
    private var gameOver = false

    // MARK: - Lifecycle

    override func didMove(to view: SKView) {
        backgroundColor = .black
        isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true

        let state = GameState.shared
        state.onePlayerHighScore = 0

        setupLinePairs(state: state)
        setupCornerEmitters(state: state)
        setupScoreLabel(state: state)
        setupPauseResume()
        startAutoDescentTimer()

        AnalyticsManager.shared.logStartedOnePlayer()
    }

    // MARK: - Setup

    private func setupLinePairs(state: GameState) {
        let colWidth = size.width / 3

        for i in 0..<3 {
            let pair = LinePair(
                columnWidth: colWidth,
                screenHeight: size.height,
                p1Color: state.p1Color,
                p2Color: state.p2Color
            )
            // Start each pair at center of screen
            pair.position = CGPoint(
                x: colWidth * CGFloat(i) + colWidth / 2,
                y: size.height / 2
            )
            addChild(pair)
            linePairs.append(pair)
        }
    }

    private func setupCornerEmitters(state: GameState) {
        let positions: [(CGPoint, SKColor)] = [
            (CGPoint(x: 0, y: size.height), state.p1Color),       // TLP
            (CGPoint(x: size.width, y: size.height), state.p1Color), // TRP
            (CGPoint(x: 0, y: 0), state.p2Color),                  // BLP
            (CGPoint(x: size.width, y: 0), state.p2Color),         // BRP
        ]

        for (pos, color) in positions {
            let emitter = makeCornerEmitter(color: color)
            emitter.position = pos
            addChild(emitter)
            cornerEmitters.append(emitter)
        }
    }

    private func setupScoreLabel(state: GameState) {
        scoreLabel.fontName = Constants.fontName
        scoreLabel.fontSize = Constants.scoreFontSize
        scoreLabel.fontColor = state.p1Color
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 80)
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.zPosition = 10
        addChild(scoreLabel)
    }

    private func setupPauseResume() {
        pauseButton.fontSize = 30
        pauseButton.position = CGPoint(x: size.width - 30, y: size.height - 40)
        pauseButton.name = "pause"
        pauseButton.zPosition = 10
        addChild(pauseButton)

        resumeButton.fontSize = 30
        resumeButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        resumeButton.name = "resume"
        resumeButton.zPosition = 10
        resumeButton.isHidden = true
        addChild(resumeButton)
    }

    // MARK: - Game Timer

    private func startAutoDescentTimer() {
        let tick = SKAction.sequence([
            SKAction.wait(forDuration: Constants.tickInterval),
            SKAction.run { [weak self] in self?.autoDescentTick() }
        ])
        run(SKAction.repeatForever(tick), withKey: "autoDescentTimer")
    }

    private func autoDescentTick() {
        guard !gameOver else { return }

        let state = GameState.shared
        state.onePlayerHighScore += 1
        scoreLabel.text = "\(state.onePlayerHighScore)"

        // Move all lines down
        for pair in linePairs {
            pair.moveVertically(by: -Constants.moveDistance)
        }

        checkVictory()
    }

    // MARK: - Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameOver else { return }

        for touch in touches {
            let location = touch.location(in: self)

            // Check pause/resume
            let tapped = atPoint(location)
            if tapped.name == "pause" {
                pauseGame()
                return
            }
            if tapped.name == "resume" {
                resumeGame()
                return
            }

            // Only process bottom half touches (player pushes up)
            guard location.y < Constants.rowBoundary(screenHeight: size.height) else { continue }
            guard bottomTouchCount < Constants.maxTouchesPerZone else { continue }

            bottomTouchCount += 1

            let (leftBound, rightBound) = Constants.columnBounds(screenWidth: size.width)
            let column: Int
            if location.x < leftBound {
                column = 0
            } else if location.x > rightBound {
                column = 2
            } else {
                column = 1
            }

            // Don't push above screen
            guard linePairs[column].position.y < size.height else { continue }

            linePairs[column].moveVertically(by: Constants.moveDistance)
            AudioManager.shared.play(Constants.soundTouch, on: self)
            checkVictory()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bottomTouchCount = max(0, bottomTouchCount - touches.count)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        bottomTouchCount = max(0, bottomTouchCount - touches.count)
    }

    // MARK: - Victory

    private func checkVictory() {
        for pair in linePairs {
            if pair.position.y < 0 {
                triggerGameOver()
                return
            }
        }
    }

    private func triggerGameOver() {
        gameOver = true
        removeAction(forKey: "autoDescentTimer")
        isUserInteractionEnabled = false

        GameState.shared.winner = 2  // AI/gravity wins

        let gameOverScene = OnePlayerGameOverScene(size: size)
        gameOverScene.scaleMode = .resizeFill
        view?.presentScene(gameOverScene, transition: .fade(withDuration: 0.5))
    }

    // MARK: - Pause

    private func pauseGame() {
        isPaused = true
        pauseButton.isHidden = true
        resumeButton.isHidden = false
    }

    private func resumeGame() {
        isPaused = false
        pauseButton.isHidden = false
        resumeButton.isHidden = true
    }

    // MARK: - Helpers

    private func makeCornerEmitter(color: SKColor) -> SKEmitterNode {
        let emitter = SKEmitterNode()
        emitter.particleBirthRate = 20
        emitter.particleLifetime = 1.5
        emitter.particleLifetimeRange = 0.5
        emitter.particleSpeed = 40
        emitter.particleSpeedRange = 20
        emitter.emissionAngleRange = .pi / 2
        emitter.particleScale = 0.03
        emitter.particleScaleRange = 0.02
        emitter.particleAlphaSpeed = -0.6
        emitter.particleColor = color
        emitter.particleColorBlendFactor = 1.0
        emitter.particleBlendMode = .add
        return emitter
    }
}
