import SpriteKit

final class TwoPlayerScene: SKScene {

    // MARK: - Properties

    private var linePairs: [LinePair] = []  // [left, middle, right]
    private var cornerEmitters: [SKEmitterNode] = []

    private let pushLabelTop = SKLabelNode(text: "PUSH")
    private let pushLabelBottom = SKLabelNode(text: "PUSH")
    private let pauseButton = SKLabelNode(text: "⏸")
    private let resumeButton = SKLabelNode(text: "▶")

    private var bottomTouches: Set<UITouch> = []
    private var topTouches: Set<UITouch> = []
    private var gameOver = false
    private var gamePaused = false

    // MARK: - Lifecycle

    override func didMove(to view: SKView) {
        backgroundColor = .black
        isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true

        let state = GameState.shared
        setupLinePairs(state: state)
        setupCornerEmitters(state: state)
        setupPushLabels(state: state)
        setupPauseResume()

        AnalyticsManager.shared.logStartedTwoPlayer(
            p1Color: state.p1Color.pushPushName,
            p2Color: state.p2Color.pushPushName
        )
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
            (CGPoint(x: 0, y: size.height), state.p1Color),
            (CGPoint(x: size.width, y: size.height), state.p1Color),
            (CGPoint(x: 0, y: 0), state.p2Color),
            (CGPoint(x: size.width, y: 0), state.p2Color),
        ]

        for (pos, color) in positions {
            let emitter = makeCornerEmitter(color: color)
            emitter.position = pos
            addChild(emitter)
            cornerEmitters.append(emitter)
        }
    }

    private func setupPushLabels(state: GameState) {
        // P2 "PUSH" at top (rotated 180° so it reads correctly from the top player's perspective)
        pushLabelTop.fontName = Constants.fontName
        pushLabelTop.fontSize = Constants.titleFontSize
        pushLabelTop.fontColor = state.p2Color
        pushLabelTop.position = CGPoint(x: size.width / 2, y: size.height - 60)
        pushLabelTop.zRotation = .pi  // Upside down for player 2
        pushLabelTop.zPosition = 10
        addChild(pushLabelTop)

        // P1 "PUSH" at bottom
        pushLabelBottom.fontName = Constants.fontName
        pushLabelBottom.fontSize = Constants.titleFontSize
        pushLabelBottom.fontColor = state.p1Color
        pushLabelBottom.position = CGPoint(x: size.width / 2, y: 60)
        pushLabelBottom.zPosition = 10
        addChild(pushLabelBottom)
    }

    private func setupPauseResume() {
        pauseButton.fontSize = 30
        pauseButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
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

    // MARK: - Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            // Check pause/resume (always responsive)
            let tapped = atPoint(location)
            if tapped.name == "pause" {
                pauseGame()
                return
            }
            if tapped.name == "resume" {
                resumeGame()
                return
            }

            guard !gameOver, !gamePaused else { return }

            let rowMid = Constants.rowBoundary(screenHeight: size.height)
            let (leftBound, rightBound) = Constants.columnBounds(screenWidth: size.width)

            let column: Int
            if location.x < leftBound {
                column = 0
            } else if location.x > rightBound {
                column = 2
            } else {
                column = 1
            }

            if location.y < rowMid {
                // Player 1 — push up
                guard bottomTouches.count < Constants.maxTouchesPerZone else { continue }
                bottomTouches.insert(touch)
                linePairs[column].moveVertically(by: Constants.moveDistance)
            } else {
                // Player 2 — push down
                guard topTouches.count < Constants.maxTouchesPerZone else { continue }
                topTouches.insert(touch)
                linePairs[column].moveVertically(by: -Constants.moveDistance)
            }

            AudioManager.shared.play(Constants.soundTouch, on: self)
            checkVictory()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeTouches(touches)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeTouches(touches)
    }

    private func removeTouches(_ touches: Set<UITouch>) {
        // Remove by identity — the touch is in whichever set it was originally added to,
        // regardless of where the finger is now (handles cross-zone drag correctly)
        bottomTouches.subtract(touches)
        topTouches.subtract(touches)
    }

    // MARK: - Victory

    private func checkVictory() {
        let state = GameState.shared

        for pair in linePairs {
            if pair.position.y > size.height {
                // Line pushed past top — Player 1 wins
                state.winner = 1
                state.p1Score += 1
                triggerGameOver()
                return
            }
            if pair.position.y < 0 {
                // Line pushed past bottom — Player 2 wins
                state.winner = 2
                state.p2Score += 1
                triggerGameOver()
                return
            }
        }
    }

    private func triggerGameOver() {
        gameOver = true
        isUserInteractionEnabled = false

        let gameOverScene = TwoPlayerGameOverScene(size: size)
        gameOverScene.scaleMode = .resizeFill
        view?.presentScene(gameOverScene, transition: .fade(withDuration: 0.5))
    }

    // MARK: - Pause

    private func pauseGame() {
        gamePaused = true
        isPaused = true
        pauseButton.isHidden = true
        resumeButton.isHidden = false
    }

    private func resumeGame() {
        gamePaused = false
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
