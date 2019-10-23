//
//  GameSession.swift
//  ReachMan
//
//  Created by Maxim on 21.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class GameSession {
    var allQuestions: Int
    var numberOfCorrectAnswers:Int

    init(allQuestions: Int, numberOfCorrectAnswers: Int) {
        self.allQuestions = allQuestions
        self.numberOfCorrectAnswers = numberOfCorrectAnswers
    }
    
}
