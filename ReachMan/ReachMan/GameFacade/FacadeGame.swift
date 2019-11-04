//
//  FacadeGame.swift
//  ReachMan
//
//  Created by Maxim on 03.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation
import UIKit

class FacadeGame {
    public var questions:[Question] = []
    
    init() {
        self.questions = createQuestions()
    }
    private var selectStrategy:CreateQuestionArray {
        switch GameSingleton.shared.gameDifficulty {
        case .consistently:
            return ConsistentlyQuestionStrategy()
        case .scatter:
            return ScatterQuestionStrategy()
        }
    }
    
    private func createQuestions() -> [Question] {
        return selectStrategy.createQuestions()
    }
}
