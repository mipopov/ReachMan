//
//  ViewController.swift
//  ReachMan
//
//  Created by Maxim on 20.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

class ViewController: UIViewController,Storyboarded {
    
    @IBOutlet var startGame: UIButton!
    @IBOutlet var bestResults: UIButton!
    @IBOutlet var settings: UIButton!
    @IBOutlet var addQuestion: UIButton!
    
    weak var coordinator: MainCoordinator?
    var gameDelegate: GameDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameDelegate = self
        coordinator?.navigationController.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.navigationController.navigationBar.isHidden = true
    }
    
    @IBAction func startGamePress(_ sender: Any) {
        coordinator?.letsStart(with: self)
    }
    @IBAction func bestResultsPress(_ sender: Any) {
        coordinator?.showResults()
    }
    
    @IBAction func settingPress(_ sender: Any) {
    }
    @IBAction func addQuestionPress(_ sender: Any) {
    }
}

extension ViewController: GameDelegate {
    
    func didEndGame(with result: Int, allNumberOfQuestion: Int) {
        let gameSession = GameSession(allQuestions: allNumberOfQuestion, numberOfCorrectAnswers: result)
        GameSingleton.shared.games = gameSession
        GameSingleton.shared.checkResults()
    }
}
