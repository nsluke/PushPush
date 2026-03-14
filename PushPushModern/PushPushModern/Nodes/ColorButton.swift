import SpriteKit

/// A tappable color swatch for the color selection screen.
final class ColorButton: SKNode {

    let playerColor: Constants.PlayerColor
    let swatch: SKSpriteNode
    private let label: SKLabelNode

    init(playerColor: Constants.PlayerColor, size: CGFloat = 36) {
        self.playerColor = playerColor

        swatch = SKSpriteNode(color: playerColor.color, size: CGSize(width: size, height: size))
        swatch.name = "colorSwatch"

        // Thin border for visibility (especially for black)
        let border = SKShapeNode(rectOf: CGSize(width: size + 2, height: size + 2))
        border.strokeColor = .gray
        border.lineWidth = 1
        border.fillColor = .clear

        label = SKLabelNode(text: playerColor.name)
        label.fontName = Constants.fontName
        label.fontSize = 10
        label.fontColor = .white
        label.verticalAlignmentMode = .top
        label.position = CGPoint(x: 0, y: -(size / 2 + 4))

        super.init()
        isUserInteractionEnabled = false
        name = "colorButton_\(playerColor.name)"

        addChild(swatch)
        addChild(border)
        addChild(label)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
