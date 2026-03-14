import UIKit
import SpriteKit

class GameViewController: UIViewController {

    private var scenePresented = false

    override func loadView() {
        let skView = SKView()
        self.view = skView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let skView = self.view as? SKView else { return }
        skView.ignoresSiblingOrder = true
        skView.isMultipleTouchEnabled = true
        #if DEBUG
        skView.showsFPS = true
        skView.showsNodeCount = true
        #endif
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Present the scene once the view has its real size
        guard !scenePresented, let skView = self.view as? SKView else { return }
        guard skView.bounds.width > 0, skView.bounds.height > 0 else { return }

        scenePresented = true
        let scene = MainMenuScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }
    override var prefersStatusBarHidden: Bool { true }
}
