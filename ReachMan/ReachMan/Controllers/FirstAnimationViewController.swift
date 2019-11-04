//
//  FirstAnimationViewController.swift
//  ReachMan
//
//  Created by Maxim on 23.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class FirstAnimationViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let animationFristScreen = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(animationFristScreen)
        self.animationFristScreen.frame = CGRect(origin: .zero, size: .zero)
        coordinator?.navigationController.navigationBar.isHidden = true
        setupFrames()
        animationTransition()
    }
    
    func setupFrames() {
        animationFristScreen.frame = self.view.frame
        animationFristScreen.image = UIImage(named: "reachMan")
    }
    
    func animationTransition() {
        self.animationFristScreen.alpha = 0
        UIView.animate(withDuration: 3, animations: {
            self.animationFristScreen.alpha = 1
        }) { _ in
            self.coordinator?.showStartGameScreen()
        }
    }

}
