//
//  MenuViewController.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 26.03.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    @IBOutlet private var segmentedControl: UISegmentedControl!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentIndex = Defaults.agent.rawValue
    }
    
    @IBAction private func didSelectAgent(_ sender: UISegmentedControl) {
        AppConstants.regulator = .init(rawValue: sender.selectedSegmentIndex)!
    }
}
