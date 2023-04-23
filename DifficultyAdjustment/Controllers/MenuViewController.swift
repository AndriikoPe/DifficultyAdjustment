//
//  MenuViewController.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logger = GameDataCollector()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
//            _ = RealAgent().getAction(for: )
        }
    }
}
