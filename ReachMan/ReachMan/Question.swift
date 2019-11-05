//
//  Question.swift
//  ReachMan
//
//  Created by Maxim on 20.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class Question: Codable {
    let questionText: String
    let firstAnswer: String
    let secondAnswer: String
    let thirdAnswer: String
    let fourthAnswer: String
    let correctNumberOfQuestion: Int
    
    init(questionText: String, firstAnswer: String, secondAnswer: String, thirdAnswer: String, fourthAnswer: String, correctNumberOfQuestion: Int) {
        self.questionText = questionText
        self.firstAnswer = firstAnswer
        self.secondAnswer = secondAnswer
        self.thirdAnswer = thirdAnswer
        self.fourthAnswer = fourthAnswer
        self.correctNumberOfQuestion = correctNumberOfQuestion
    }
}
