import SpriteKit

/// A movable unit containing a top line, bottom line, gradient fill, and particle emitters.
/// In the original game, each column (left/middle/right) is one LinePair.
final class LinePair: SKNode {

    let topLine: SKSpriteNode
    let bottomLine: SKSpriteNode
    let gradient: GradientNode
    let upperEmitter: SKEmitterNode
    let lowerEmitter: SKEmitterNode

    private let columnWidth: CGFloat
    private let screenHeight: CGFloat

    /// - Parameters:
    ///   - columnWidth: Width of this column (typically screenWidth / 3)
    ///   - screenHeight: Full screen height for gradient sizing
    ///   - p1Color: Player 1 (bottom) color
    ///   - p2Color: Player 2 (top) color
    init(columnWidth: CGFloat, screenHeight: CGFloat, p1Color: SKColor, p2Color: SKColor) {
        self.columnWidth = columnWidth
        self.screenHeight = screenHeight

        let lineW = max(1, columnWidth - Constants.linePadding * 2)
        let lineH = Constants.lineHeight

        // Bottom line (P1 color) — at the lower end of this pair
        bottomLine = SKSpriteNode(color: p1Color, size: CGSize(width: lineW, height: lineH))
        bottomLine.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bottomLine.position = CGPoint(x: 0, y: -lineH / 2)

        // Top line (P2 color) — at the upper end
        topLine = SKSpriteNode(color: p2Color, size: CGSize(width: lineW, height: lineH))
        topLine.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        topLine.position = CGPoint(x: 0, y: lineH / 2)

        // Gradient between the two lines
        let gradientHeight = lineH * 2
        gradient = GradientNode(
            size: CGSize(width: lineW, height: gradientHeight),
            topColor: p2Color,
            bottomColor: p1Color
        )
        gradient.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.position = .zero

        // Particle emitters
        upperEmitter = LinePair.makeEmitter(color: p1Color)
        upperEmitter.position = CGPoint(x: 0, y: lineH)

        lowerEmitter = LinePair.makeEmitter(color: p2Color)
        lowerEmitter.position = CGPoint(x: 0, y: -lineH)

        super.init()

        addChild(gradient)
        addChild(bottomLine)
        addChild(topLine)
        addChild(upperEmitter)
        addChild(lowerEmitter)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Move this line pair vertically by a delta.
    func moveVertically(by delta: CGFloat) {
        position.y += delta
    }

    /// Update colors (e.g. after color selection).
    func updateColors(p1Color: SKColor, p2Color: SKColor) {
        bottomLine.color = p1Color
        topLine.color = p2Color
        gradient.updateColors(topColor: p2Color, bottomColor: p1Color)
        upperEmitter.particleColor = p1Color
        lowerEmitter.particleColor = p2Color
    }

    private static func makeEmitter(color: SKColor) -> SKEmitterNode {
        let emitter = SKEmitterNode()
        emitter.particleBirthRate = 30
        emitter.particleLifetime = 1.0
        emitter.particleLifetimeRange = 0.5
        emitter.particleSpeed = 30
        emitter.particleSpeedRange = 15
        emitter.emissionAngleRange = .pi * 2
        emitter.particleScale = 0.04
        emitter.particleScaleRange = 0.02
        emitter.particleAlphaSpeed = -0.8
        emitter.particleColor = color
        emitter.particleColorBlendFactor = 1.0
        emitter.particleBlendMode = .add
        emitter.targetNode = emitter.parent
        return emitter
    }
}
