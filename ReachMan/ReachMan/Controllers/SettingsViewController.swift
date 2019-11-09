//
//  SettingsViewController.swift
//  ReachMan
//
//  Created by Maxim on 01.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,Storyboarded {
    @IBOutlet var gameDifficultyControl: UISegmentedControl!
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDiffuculty()
        coordinator?.navigationController.navigationBar.isHidden = false
    }
    
    private func checkDiffuculty() {
        if GameSingleton.shared.gameDifficulty == .scatter {
            gameDifficultyControl.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func changeGameDifficulty(_ sender: Any) {
        switch self.gameDifficultyControl.selectedSegmentIndex {
        case 0:
            GameSingleton.shared.gameDifficulty = .consistently
        case 1:
            GameSingleton.shared.gameDifficulty = .scatter
        default:
            GameSingleton.shared.gameDifficulty = .consistently
        }
    }
}
