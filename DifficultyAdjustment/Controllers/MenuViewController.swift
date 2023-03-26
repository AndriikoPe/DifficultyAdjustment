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
    
    
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.sizeToFit()
    }
}
