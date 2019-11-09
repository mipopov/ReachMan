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
    
    public func createQuestions() -> [Question] {
        return selectStrategy.createQuestions()
    }
    
    public func hallHelp(with button: UIButton){
        button.alpha = 0.5
        button.isEnabled = false
    }
    public func callToFriend(with button: UIButton){
        button.alpha = 0.5
        button.isEnabled = false
    }
    
    public func doubleChance(with button: UIButton) {
        button.alpha = 0.5
        button.isEnabled = false
    }
    public func deleteTwoAnswers(with button: UIButton) {
        button.alpha = 0.5
        button.isEnabled = false
    }
    public func hideButtons(with correctAnswer: Int, firstAnswerButton: UIButton, secondAnswerButton:UIButton, thirdAnswerButton: UIButton, fourthAnswerButton: UIButton) {
        
        var arrayOfAnswers = [1, 2, 3, 4]
        arrayOfAnswers = arrayOfAnswers.filter({$0 != correctAnswer})
        
        guard let firstRandomNumber = arrayOfAnswers.randomElement() else {return}
        arrayOfAnswers = arrayOfAnswers.filter({ $0 != firstRandomNumber})
        
        guard let secondRandomNumber = arrayOfAnswers.randomElement() else {return}
        
        if firstRandomNumber == 1 || secondRandomNumber == 1{
            firstAnswerButton.isHidden = true
        }
        if firstRandomNumber == 2 || secondRandomNumber == 2{
            secondAnswerButton.isHidden = true
        }
        if firstRandomNumber == 3 || secondRandomNumber == 3{
            thirdAnswerButton.isHidden = true
        }
        if firstRandomNumber == 4 || secondRandomNumber == 4{
            fourthAnswerButton.isHidden = true
        }
    }
}
