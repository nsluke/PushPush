import SpriteKit

final class AudioManager {
    static let shared = AudioManager()

    private var actions: [String: SKAction] = [:]

    private init() {
        let soundFiles = [
            Constants.soundTouch,
            Constants.soundGameOver,
            Constants.soundGameStart,
        ]
        for file in soundFiles {
            actions[file] = SKAction.playSoundFileNamed(file, waitForCompletion: false)
        }
    }

    func play(_ sound: String, on node: SKNode) {
        guard let action = actions[sound] else { return }
        node.run(action)
    }
}
