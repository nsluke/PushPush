import SpriteKit

extension SKColor {
    /// Returns the matching color name from Constants.playerColors, or "Unknown".
    var pushPushName: String {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)

        for pc in Constants.playerColors {
            var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
            pc.color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
            if abs(r1 - r2) < 0.01 && abs(g1 - g2) < 0.01 && abs(b1 - b2) < 0.01 {
                return pc.name
            }
        }
        return "Unknown"
    }
}
