//
//  GameViewController.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as! SKView? else { return }
        
        let scene = GameScene(size: AppConstants.sceneSize)
        scene.scaleMode = .aspectFill
        scene.gameStateDelegate = self
        view.presentScene(scene)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GameStateDelegate {
    func end(with time: TimeInterval) {
        let minutes = Int(time / 60)
        let seconds = Int(time) % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        guard let endGameVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                withIdentifier: String(describing: LoseController.self)
            ) as? LoseController,
              let controllers = navigationController?.viewControllers
        else { return }
        
        endGameVC.lastedTime = "\(minutesString):\(secondsString)"
        
        let newVcStack = controllers.filter { !($0 is GameViewController) } + [endGameVC]
        
        navigationController?.setViewControllers(newVcStack, animated: true)
    }
}
