//
//  MainCoordinator.swift
//  CoordinatorExample
//
//  Created by user on 30/01/2019.
//  Copyright © 2019 Morizo Digital. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = FirstAnimationViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showStartGameScreen() {
        let startScreen = ViewController.instantiate()
        startScreen.coordinator = self
        navigationController.pushViewController(startScreen, animated: true)
    }
    func letsStart(with gameDelegate: GameDelegate?) {
        let gameScreen = GameViewController.instantiate()
        gameScreen.gameDelegate = gameDelegate
        gameScreen.coordinator = self
        navigationController.pushViewController(gameScreen, animated: true)
    }
    
    func showResults() {
        let resultsScreen = ResultsViewController.instantiate()
        resultsScreen.coordinator = self
        navigationController.pushViewController(resultsScreen, animated: true)
    }
}
