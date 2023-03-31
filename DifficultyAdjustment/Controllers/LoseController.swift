//
//  LoseController.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import UIKit

final class LoseController: UIViewController {
   
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }
    
    var lastedTime: String?
    
    @IBOutlet private var timeLabel: UILabel!
    @IBAction private func menuTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = lastedTime
        AppConstants.gameDifficultyKnob = AppConstants.initialDifiiculty
    }
}
