//
//  GameResults.swift
//  ReachMan
//
//  Created by Maxim on 21.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class GameResults: Codable {
    let questionPercent: Double
    let numberOfCorrectAnswers: Int
    let allnumberOfQuestion: Int
    
    init(questionPercent: Double, numberOfCorrectAnswers: Int, allnumberOfQuestion: Int) {
        self.allnumberOfQuestion = allnumberOfQuestion + 1
        self.numberOfCorrectAnswers = numberOfCorrectAnswers + 1
        self.questionPercent = questionPercent
    }
    
}
