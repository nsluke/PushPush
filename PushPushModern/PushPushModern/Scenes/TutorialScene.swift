import SpriteKit

final class TutorialScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .black
        isUserInteractionEnabled = true

        setupInstructions()
        setupBackButton()
    }

    private func setupInstructions() {
        let centerX = size.width / 2

        let title = SKLabelNode(text: "HOW TO PLAY")
        title.fontName = Constants.fontName
        title.fontSize = 32
        title.fontColor = .white
        title.position = CGPoint(x: centerX, y: size.height - 100)
        addChild(title)

        let instructions = [
            "Tap the bottom of the screen",
            "to push the lines UP.",
            "",
            "Left side = left line",
            "Middle = middle line",
            "Right side = right line",
            "",
            "Don't let the lines reach",
            "the bottom of the screen!",
        ]

        for (i, text) in instructions.enumerated() {
            let label = SKLabelNode(text: text)
            label.fontName = Constants.fontName
            label.fontSize = 18
            label.fontColor = .lightGray
            label.position = CGPoint(x: centerX, y: size.height - 180 - CGFloat(i) * 28)
            addChild(label)
        }

        let tapToStart = SKLabelNode(text: "TAP TO START")
        tapToStart.fontName = Constants.fontName
        tapToStart.fontSize = Constants.buttonFontSize
        tapToStart.fontColor = GameState.shared.p1Color
        tapToStart.name = "start"
        tapToStart.position = CGPoint(x: centerX, y: 140)
        tapToStart.verticalAlignmentMode = .center
        addChild(tapToStart)

        // Pulse animation
        let pulse = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.4, duration: 0.8),
            SKAction.fadeAlpha(to: 1.0, duration: 0.8),
        ])
        tapToStart.run(SKAction.repeatForever(pulse))
    }

    private func setupBackButton() {
        let back = SKLabelNode(text: "← BACK")
        back.fontName = Constants.fontName
        back.fontSize = 18
        back.fontColor = .gray
        back.name = "back"
        back.position = CGPoint(x: 60, y: size.height - 50)
        back.verticalAlignmentMode = .center
        addChild(back)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tapped = atPoint(location)

        if tapped.name == "back" {
            let menu = MainMenuScene(size: size)
            menu.scaleMode = .resizeFill
            view?.presentScene(menu, transition: .fade(withDuration: 0.4))
            return
        }

        // Any other touch starts the game
        GameState.shared.gameMode = .onePlayer
        GameState.shared.resetForNewGame()
        let scene = OnePlayerScene(size: size)
        scene.scaleMode = .resizeFill
        view?.presentScene(scene, transition: .fade(withDuration: 0.3))
    }
}
