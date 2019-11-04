//
//  GameViewController.swift
//  ReachMan
//
//  Created by Maxim on 20.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import UIKit

protocol GameDelegate {
    func didEndGame(with result:Int, allNumberOfQuestion: Int)
}

class GameViewController: UIViewController, Storyboarded {
    @IBOutlet var countOfPassesQuestionLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var callToFriendButton: UIButton!
    @IBOutlet var fiftyFiftyButton: UIButton!
    @IBOutlet var peopleHelpButton: UIButton!
    @IBOutlet var tryToErrorButton: UIButton!
    
    @IBOutlet var firstAnswerButton: UIButton!
    @IBOutlet var secondAnswerButton: UIButton!
    @IBOutlet var thirdAnswerButton: UIButton!
    @IBOutlet var fourthAnswerButton: UIButton!
    
    weak var coordinator: MainCoordinator?
    var gameDelegate: GameDelegate?
    var facadeGame:FacadeGame!
    
    var questions = [Question]()
    var questionNumber = Observable<Int>(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator?.navigationController.navigationBar.isHidden = false
        questions = facadeGame.createQuestions()
        
        setupTextFields()
        
        self.questionNumber.addObserver(self, removeIfExists: true, options: [.new, .initial]) {[weak self] (number, _) in
            guard let self = self else {return}
            self.countOfPassesQuestionLabel.text = "Вопрос \(number + 1) из \(self.questions.count + 1)"
        }
    }
    
    
    private func setupTextFields(){
        self.questionLabel.text = questions[0].questionText
        self.firstAnswerButton.setTitle(questions[0].answers.firstAnswer, for: .normal)
        self.secondAnswerButton.setTitle(questions[0].answers.secondAnswer, for: .normal)
        self.thirdAnswerButton.setTitle(questions[0].answers.thirdAnswer, for: .normal)
        self.fourthAnswerButton.setTitle(questions[0].answers.fourthAnswer, for: .normal)
        
        self.firstAnswerButton.addTarget(self, action: #selector(tapOnfirstButton), for: .touchUpInside)
        self.secondAnswerButton.addTarget(self, action: #selector(tapOnSecondButton), for: .touchUpInside)
        self.thirdAnswerButton.addTarget(self, action: #selector(tapOnThirdButton), for: .touchUpInside)
        self.fourthAnswerButton.addTarget(self, action: #selector(tapOnfourthButton), for: .touchUpInside)
    }
    
    @IBAction func doubleChance(_ sender: Any) {
        facadeGame.trytoErrorFlag = true
        self.tryToErrorButton.alpha = 0.5
        self.tryToErrorButton.isEnabled = false
    }
    
    @IBAction func deleteTwoAnswers(_ sender: Any) {
        self.fiftyFiftyButton.alpha = 0.5
        self.fiftyFiftyButton.isEnabled = false
        let correctAnswer = questions[questionNumber.value].answers.correctNumberOfQuestion
        hiddenButtons(with: correctAnswer)
        
    }
    
    private func hiddenButtons(with correctNumber:Int) {
        var arrayOfAnswers = [1, 2, 3, 4]
        arrayOfAnswers = arrayOfAnswers.filter({$0 != correctNumber})

        guard let firstRandomNumber = arrayOfAnswers.randomElement() else {return}
        arrayOfAnswers = arrayOfAnswers.filter({ $0 != firstRandomNumber})
        
        guard let secondRandomNumber = arrayOfAnswers.randomElement() else {return}

        if firstRandomNumber == 1 || secondRandomNumber == 1{
            self.firstAnswerButton.isHidden = true
        }
        if firstRandomNumber == 2 || secondRandomNumber == 2{
            self.secondAnswerButton.isHidden = true
        }
        if firstRandomNumber == 3 || secondRandomNumber == 3{
            self.thirdAnswerButton.isHidden = true
        }
        if firstRandomNumber == 4 || secondRandomNumber == 4{
            self.fourthAnswerButton.isHidden = true
        }
        
        
    }
    
    @objc func tapOnfirstButton() {
        let correctAnswer = questions[questionNumber.value].answers.correctNumberOfQuestion
        if correctAnswer == 1 {
            questionNumber.value += 1
            self.switchQuestion(with: questionNumber.value)
        } else {
            if facadeGame.trytoErrorFlag == true {
                self.firstAnswerButton.backgroundColor = .red
                self.firstAnswerButton.isEnabled = false
                facadeGame.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    @objc func tapOnSecondButton() {
        let correctAnswer = questions[questionNumber.value].answers.correctNumberOfQuestion
        if correctAnswer == 2 {
            questionNumber.value += 1
            self.switchQuestion(with: questionNumber.value)
        } else {
            if facadeGame.trytoErrorFlag == true {
                self.secondAnswerButton.backgroundColor = .red
                self.secondAnswerButton.isEnabled = false
                facadeGame.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    @objc func tapOnThirdButton() {
        let correctAnswer = questions[questionNumber.value].answers.correctNumberOfQuestion
        if correctAnswer == 3 {
            questionNumber.value += 1
            self.switchQuestion(with: questionNumber.value)
        } else {
            if facadeGame.trytoErrorFlag == true {
                self.thirdAnswerButton.backgroundColor = .red
                self.thirdAnswerButton.isEnabled = false
                facadeGame.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    @objc func tapOnfourthButton() {
        let correctAnswer = questions[questionNumber.value].answers.correctNumberOfQuestion
        if correctAnswer == 4 {
            questionNumber.value += 1
            self.switchQuestion(with: questionNumber.value)
        } else {
            if facadeGame.trytoErrorFlag == true {
                self.fourthAnswerButton.backgroundColor = .red
                self.fourthAnswerButton.isEnabled = false
                facadeGame.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    private func switchQuestion(with questionNumber: Int) {
        if facadeGame.trytoErrorFlag == true {
            facadeGame.trytoErrorFlag = false
        }
        
        self.firstAnswerButton.isHidden = false
        self.firstAnswerButton.backgroundColor = .yellow
        self.firstAnswerButton.isEnabled = true
        
        self.secondAnswerButton.isHidden = false
        self.secondAnswerButton.backgroundColor = .yellow
        self.secondAnswerButton.isEnabled = true

        self.thirdAnswerButton.isHidden = false
        self.thirdAnswerButton.backgroundColor = .yellow
        self.thirdAnswerButton.isEnabled = true

        self.fourthAnswerButton.isHidden = false
        self.fourthAnswerButton.backgroundColor = .yellow
        self.fourthAnswerButton.isEnabled = true

        if questionNumber == questions.count {
            winGame()
            
        } else {
            self.questionLabel.text = questions[questionNumber].questionText
            self.firstAnswerButton.setTitle(questions[questionNumber].answers.firstAnswer, for: .normal)
            self.secondAnswerButton.setTitle(questions[questionNumber].answers.secondAnswer, for: .normal)
            self.thirdAnswerButton.setTitle(questions[questionNumber].answers.thirdAnswer, for: .normal)
            self.fourthAnswerButton.setTitle(questions[questionNumber].answers.fourthAnswer, for: .normal)
        }
    }
    
    private func winGame() {
        self.gameDelegate?.didEndGame(with: questionNumber.value, allNumberOfQuestion: questions.count)
        
        self.firstAnswerButton.alpha = 0
        self.secondAnswerButton.alpha = 0
        self.thirdAnswerButton.alpha = 0
        self.fourthAnswerButton.alpha = 0
        self.callToFriendButton.alpha = 0
        self.fiftyFiftyButton.alpha = 0
        self.peopleHelpButton.alpha = 0
        self.tryToErrorButton.alpha = 0
        
        self.view.backgroundColor = .red
        self.questionLabel.text = "ТЫ ВЫИГРАЛЛЛ !!! Твой результат - \(self.questionNumber.value + 1)"
        
    }
    
    private func gameOver() {
        self.gameDelegate?.didEndGame(with: questionNumber.value, allNumberOfQuestion: questions.count)
        
        UIView.animate(withDuration: 1) {
            self.firstAnswerButton.alpha = 0
            self.secondAnswerButton.alpha = 0
            self.thirdAnswerButton.alpha = 0
            self.fourthAnswerButton.alpha = 0
            self.callToFriendButton.alpha = 0
            self.fiftyFiftyButton.alpha = 0
            self.peopleHelpButton.alpha = 0
            self.tryToErrorButton.alpha = 0
            
            self.view.backgroundColor = .red
            self.questionLabel.text = "Твой результат \(self.questionNumber.value + 1)"
        }
    }
}
