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
    public var trytoErrorFlag:Bool
    
    init() {
        trytoErrorFlag = false
    }
    
    private var selectStrategy:CreateQuestionArray {
        switch GameSingleton.shared.gameDifficulty {
        case .consistently:
            return ConsistentlyQuestionStrategy()
        case .scatter:
            return ScatterQuestionStrategy()
        }
    }
    
    func createQuestions() -> [Question] {
        return selectStrategy.createQuestions()
    }
    
    
}
