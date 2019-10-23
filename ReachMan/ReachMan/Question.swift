//
//  Question.swift
//  ReachMan
//
//  Created by Maxim on 20.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

struct Question {
    let questionText: String
    let answers: Answers
    let questionNumber: Int
    var fiftyFifty: Bool
    var peopleHelp: Bool
    var tryToError: Bool
    var callToFriend: Bool
    let countOfMoney: Int
}

struct Answers {
    let firstAnswer: String
    let secondAnswer: String
    let thirdAnswer: String
    let fourthAnswer: String
    let correctNumberOfQuestion: Int
}