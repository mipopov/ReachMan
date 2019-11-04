//
//  Builder.swift
//  ReachMan
//
//  Created by Maxim on 03.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class Builder {
    private(set) var textQuestion: String = ""
    
    private(set) var firstAnswer: String = ""
    private(set) var secondAnswer: String = ""
    private(set) var thirdAnswer: String = ""
    private(set) var fourthAnswer: String = ""
    private(set) var correctAnswer: String = ""
    
    func build() -> Question {
        return Question(questionText: textQuestion, answers:Answers(firstAnswer: firstAnswer, secondAnswer: secondAnswer, thirdAnswer: thirdAnswer, fourthAnswer: fourthAnswer, correctNumberOfQuestion: Int(correctAnswer) ?? 1), questionNumber: 1, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 64_000)
    }
    func setFirstAnswer(_ text: String) {
        self.firstAnswer = text
    }
    func setSecondAnswer(_ text: String) {
        self.secondAnswer = text
    }
    func setThirdAnswer(_ text: String) {
        self.thirdAnswer = text
    }
    func setFourthAnswer(_ text: String) {
        self.fourthAnswer = text
    }
    func setTextQuestion(_ text: String) {
        self.textQuestion = text
    }
    func correctAnswer(_ text: String) {
        self.correctAnswer = text
    }
    
}
