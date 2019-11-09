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
        self.firstAnswerButton.setTitle(questions[0].firstAnswer, for: .normal)
        self.secondAnswerButton.setTitle(questions[0].secondAnswer, for: .normal)
        self.thirdAnswerButton.setTitle(questions[0].thirdAnswer, for: .normal)
        self.fourthAnswerButton.setTitle(questions[0].fourthAnswer, for: .normal)
        
        self.firstAnswerButton.layer.cornerRadius = 10
        self.secondAnswerButton.layer.cornerRadius = 10
        self.thirdAnswerButton.layer.cornerRadius = 10
        self.fourthAnswerButton.layer.cornerRadius = 10
        
        self.callToFriendButton.layer.cornerRadius = 10
        self.fiftyFiftyButton.layer.cornerRadius = 10
        self.peopleHelpButton.layer.cornerRadius = 10
        self.tryToErrorButton.layer.cornerRadius = 10
        
        countOfPassesQuestionLabel.layer.cornerRadius = 10
        countOfPassesQuestionLabel.clipsToBounds = true
        countOfPassesQuestionLabel.textAlignment = .center
        
        self.firstAnswerButton.addTarget(self, action: #selector(tapOnfirstButton), for: .touchUpInside)
        self.secondAnswerButton.addTarget(self, action: #selector(tapOnSecondButton), for: .touchUpInside)
        self.thirdAnswerButton.addTarget(self, action: #selector(tapOnThirdButton), for: .touchUpInside)
        self.fourthAnswerButton.addTarget(self, action: #selector(tapOnfourthButton), for: .touchUpInside)
    }
    
    @IBAction func helpOfHall(_ sender: Any) {
        facadeGame.hallHelp(with: peopleHelpButton)
        
        let arrayOfAnswers = [1, 2, 3, 4]
        guard let friendOpinionAnswer = arrayOfAnswers.randomElement() else {return}
        
        let alertController = UIAlertController(title: "Зал считает верный ответ под номером  \(friendOpinionAnswer)", message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Хорошо", style: .default)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
        
    }
    
    @IBAction func callFriend(_ sender: Any) {
        facadeGame.callToFriend(with: callToFriendButton)
        
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
        let alertController = UIAlertController(title: "Твой друг думает,что верный ответ под номером \(correctAnswer)", message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Хорошо", style: .default)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    @IBAction func doubleChance(_ sender: Any) {
        facadeGame.trytoErrorFlag = true
        facadeGame.doubleChance(with: tryToErrorButton)
    }
    
    @IBAction func deleteTwoAnswers(_ sender: Any) {
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
        facadeGame.doubleChance(with: fiftyFiftyButton)
        facadeGame.hideButtons(with: correctAnswer, firstAnswerButton: self.firstAnswerButton, secondAnswerButton: self.secondAnswerButton, thirdAnswerButton: self.thirdAnswerButton, fourthAnswerButton: self.fourthAnswerButton)
        
    }
    
    @objc func tapOnfirstButton() {
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
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
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
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
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
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
        let correctAnswer = questions[questionNumber.value].correctNumberOfQuestion
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
            self.firstAnswerButton.setTitle(questions[questionNumber].firstAnswer, for: .normal)
            self.secondAnswerButton.setTitle(questions[questionNumber].secondAnswer, for: .normal)
            self.thirdAnswerButton.setTitle(questions[questionNumber].thirdAnswer, for: .normal)
            self.fourthAnswerButton.setTitle(questions[questionNumber].fourthAnswer, for: .normal)
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
        self.countOfPassesQuestionLabel.alpha = 0
        
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
            self.countOfPassesQuestionLabel.alpha = 0

            self.view.backgroundColor = .red
            self.questionLabel.text = "Твой результат \(self.questionNumber.value + 1)"
        }
    }
}
