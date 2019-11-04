//
//  GameSingleton.swift
//  ReachMan
//
//  Created by Maxim on 21.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class GameSingleton {
    static let shared = GameSingleton()
    var games: GameSession?
    var gameDifficulty: GameDifficulty = .consistently
    
    var results: [GameResults] {

        didSet {
            careTracker.save(self.results)
        }

    }
    
    private let careTracker = CareTracker()
    
    func checkResults() {
        guard let correctAnswers = games?.numberOfCorrectAnswers,
            let allAnswers = games?.allQuestions else {return}
        let percent = Double(Double(correctAnswers)/Double(allAnswers) * 100).rounded()
        
        let result = GameResults(questionPercent: percent, numberOfCorrectAnswers: correctAnswers, allnumberOfQuestion: allAnswers)
        results.append(result)
        games = nil
    }
    
    private init() {
        self.results = self.careTracker.retrieveGames().reversed()
        
    }
}
