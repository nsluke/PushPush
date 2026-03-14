import SpriteKit

/// A sprite node that displays a vertical gradient between two colors.
final class GradientNode: SKSpriteNode {

    init(size: CGSize, topColor: SKColor, bottomColor: SKColor) {
        let texture = GradientNode.makeGradientTexture(size: size, topColor: topColor, bottomColor: bottomColor)
        super.init(texture: texture, color: .clear, size: size)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateColors(topColor: SKColor, bottomColor: SKColor) {
        let tex = GradientNode.makeGradientTexture(size: self.size, topColor: topColor, bottomColor: bottomColor)
        self.texture = tex
    }

    private static func makeGradientTexture(size: CGSize, topColor: SKColor, bottomColor: SKColor) -> SKTexture {
        let w = max(Int(size.width), 1)
        let h = max(Int(size.height), 1)

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: w, height: h))
        let image = renderer.image { ctx in
            let colors = [topColor.cgColor, bottomColor.cgColor] as CFArray
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: [0, 1]) else { return }
            ctx.cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0, y: 0),      // top in UIKit coords
                end: CGPoint(x: 0, y: CGFloat(h)), // bottom in UIKit coords
                options: []
            )
        }
        return SKTexture(image: image)
    }
}
