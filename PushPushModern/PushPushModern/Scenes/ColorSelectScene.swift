import SpriteKit

final class ColorSelectScene: SKScene {

    // Which player is currently selecting (1 or 2)
    private var selectingPlayer = 1

    private let instructionLabel = SKLabelNode(text: "PLAYER 1 — PICK YOUR COLOR")
    private let doneButton = SKLabelNode(text: "DONE")
    private let warningLabel = SKLabelNode(text: "Players can't be the same color!")

    private var colorButtons: [ColorButton] = []

    // Preview elements
    private var previewLines: [SKSpriteNode] = []
    private var previewGradients: [GradientNode] = []

    override func didMove(to view: SKView) {
        backgroundColor = .black
        isUserInteractionEnabled = true

        setupInstruction()
        setupColorButtons()
        setupPreview()
        setupDoneButton()
        setupWarning()
        updatePreview()
    }

    // MARK: - Setup

    private func setupInstruction() {
        instructionLabel.fontName = Constants.fontName
        instructionLabel.fontSize = 18
        instructionLabel.fontColor = GameState.shared.p1Color
        instructionLabel.position = CGPoint(x: size.width / 2, y: size.height - 60)
        addChild(instructionLabel)
    }

    private func setupColorButtons() {
        let count = Constants.playerColors.count
        let buttonSize: CGFloat = 36
        let spacing: CGFloat = 4
        let totalWidth = CGFloat(count) * buttonSize + CGFloat(count - 1) * spacing
        let startX = (size.width - totalWidth) / 2 + buttonSize / 2
        let y = size.height - 130

        for (i, pc) in Constants.playerColors.enumerated() {
            let btn = ColorButton(playerColor: pc, size: buttonSize)
            btn.position = CGPoint(x: startX + CGFloat(i) * (buttonSize + spacing), y: y)
            btn.name = "colorButton_\(pc.name)"
            addChild(btn)
            colorButtons.append(btn)
        }
    }

    private func setupPreview() {
        let state = GameState.shared
        let colWidth = size.width / 3
        let lineW = max(1, colWidth - Constants.linePadding * 2)
        let centerY = size.height / 2

        // 3 columns of preview: top line (P2), gradient, bottom line (P1)
        for i in 0..<3 {
            let x = colWidth * CGFloat(i) + colWidth / 2

            let topLine = SKSpriteNode(color: state.p2Color, size: CGSize(width: lineW, height: Constants.lineHeight))
            topLine.position = CGPoint(x: x, y: centerY + 40)
            addChild(topLine)
            previewLines.append(topLine)

            let bottomLine = SKSpriteNode(color: state.p1Color, size: CGSize(width: lineW, height: Constants.lineHeight))
            bottomLine.position = CGPoint(x: x, y: centerY - 40)
            addChild(bottomLine)
            previewLines.append(bottomLine)

            let grad = GradientNode(
                size: CGSize(width: lineW, height: 76),
                topColor: state.p2Color,
                bottomColor: state.p1Color
            )
            grad.position = CGPoint(x: x, y: centerY)
            addChild(grad)
            previewGradients.append(grad)
        }
    }

    private func setupDoneButton() {
        doneButton.fontName = Constants.fontName
        doneButton.fontSize = Constants.buttonFontSize
        doneButton.fontColor = .white
        doneButton.name = "done"
        doneButton.position = CGPoint(x: size.width / 2, y: 80)
        doneButton.verticalAlignmentMode = .center
        addChild(doneButton)
    }

    private func setupWarning() {
        warningLabel.fontName = Constants.fontName
        warningLabel.fontSize = 14
        warningLabel.fontColor = .red
        warningLabel.position = CGPoint(x: size.width / 2, y: 50)
        warningLabel.isHidden = true
        addChild(warningLabel)
    }

    // MARK: - Touch

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tapped = atPoint(location)
        let name = tapped.name ?? tapped.parent?.name ?? ""

        // Check color buttons
        if name.hasPrefix("colorButton_") || name == "colorSwatch" {
            // Find the ColorButton ancestor
            var node: SKNode? = tapped
            while let n = node, !(n is ColorButton) { node = n.parent }
            guard let colorButton = node as? ColorButton else { return }

            selectColor(colorButton.playerColor.color)
            return
        }

        // Done button
        if name == "done" {
            if colorsAreSame() {
                warningLabel.isHidden = false
                return
            }
            let menu = MainMenuScene(size: size)
            menu.scaleMode = .resizeFill
            view?.presentScene(menu, transition: .fade(withDuration: 0.4))
        }
    }

    // MARK: - Color Logic

    private func selectColor(_ color: SKColor) {
        let state = GameState.shared

        if selectingPlayer == 1 {
            state.p1Color = color
        } else {
            state.p2Color = color
        }

        // Toggle to other player
        selectingPlayer = selectingPlayer == 1 ? 2 : 1
        updateInstructionLabel()
        updatePreview()

        // Hide warning if colors are now different
        if !colorsAreSame() {
            warningLabel.isHidden = true
        }

        // Rotate color buttons (fun visual flourish from original)
        for btn in colorButtons {
            btn.run(SKAction.rotate(byAngle: .pi, duration: 0.2))
        }
    }

    private func colorsAreSame() -> Bool {
        let state = GameState.shared
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0
        state.p1Color.getRed(&r1, green: &g1, blue: &b1, alpha: nil)
        state.p2Color.getRed(&r2, green: &g2, blue: &b2, alpha: nil)
        return abs(r1 - r2) < 0.01 && abs(g1 - g2) < 0.01 && abs(b1 - b2) < 0.01
    }

    private func updateInstructionLabel() {
        let state = GameState.shared
        if selectingPlayer == 1 {
            instructionLabel.text = "PLAYER 1 — PICK YOUR COLOR"
            instructionLabel.fontColor = state.p1Color
        } else {
            instructionLabel.text = "PLAYER 2 — PICK YOUR COLOR"
            instructionLabel.fontColor = state.p2Color
        }
    }

    private func updatePreview() {
        let state = GameState.shared

        // Preview lines: even indices = top (P2), odd indices = bottom (P1)
        for (i, line) in previewLines.enumerated() {
            line.color = (i % 2 == 0) ? state.p2Color : state.p1Color
        }

        for grad in previewGradients {
            grad.updateColors(topColor: state.p2Color, bottomColor: state.p1Color)
        }
    }
}
