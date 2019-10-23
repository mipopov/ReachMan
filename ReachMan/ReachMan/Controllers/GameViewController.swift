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

class GameViewController: UIViewController,Storyboarded {
    var gameDelegate: GameDelegate?
    
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
    
    var questions:[Question] = [
        
        Question(questionText: "Что растёт в огороде?", answers: Answers(firstAnswer: "Лук", secondAnswer: "Пистолет", thirdAnswer: "Пулемёт", fourthAnswer: "Луна", correctNumberOfQuestion: 1), questionNumber: 1, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 500),
        
        Question(questionText: "Что делит угол пополам?", answers: Answers(firstAnswer: "Биссектриса", secondAnswer: "Триссектриса", thirdAnswer: "Медиана", fourthAnswer: "Ты", correctNumberOfQuestion: 1), questionNumber: 2, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 1000),
        
        Question(questionText: "О чём писал Грибоедов, отмечая, что он 'нам сладок и приятен' ? ", answers: Answers(firstAnswer: "Дух купечества", secondAnswer: "Дым Отечества", thirdAnswer: "Дар пророчества", fourthAnswer: "Пыл девичества", correctNumberOfQuestion: 2), questionNumber: 3, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 2000),
        
        Question(questionText: "Какого персонажа нет в известной считалке «На золотом крыльце сидели?»", answers: Answers(firstAnswer: "Сапожника", secondAnswer: "Короля", thirdAnswer: "Кузнеца", fourthAnswer: "Портного", correctNumberOfQuestion: 3), questionNumber: 4, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false,countOfMoney: 4000),
        
        Question(questionText: "Что такое десница? ", answers: Answers(firstAnswer: "Бровь", secondAnswer: "Рука ", thirdAnswer: "Шея", fourthAnswer: "Глаз", correctNumberOfQuestion: 2), questionNumber: 5, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 8000),
        
        Question(questionText: "Как назывался каменный монолит, на котором установлен памятник Петру I в Санкт-Петербурге? ", answers: Answers(firstAnswer: "Дом-камень", secondAnswer: "Разрыв-камень", thirdAnswer: "Гром-камень", fourthAnswer: "Гора-камень", correctNumberOfQuestion: 4),
                 questionNumber: 6, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 16_000),
        Question(questionText: "Какое животное имеет второе название — кугуар?", answers: Answers(firstAnswer: "Оцелот", secondAnswer: "Леопард", thirdAnswer: "Пума", fourthAnswer: "Пантера", correctNumberOfQuestion: 3), questionNumber: 7, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 32_000)
    ]
    
    var questionNumber = 0
    var trytoErrorFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinator?.navigationController.navigationBar.isHidden = false
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        coordinator?.navigationController.navigationBar.isHidden = false
    }
    
 
    @IBAction func doubleChance(_ sender: Any) {
        trytoErrorFlag = true
        questions[questionNumber].tryToError = true
        self.tryToErrorButton.alpha = 0.5
        self.tryToErrorButton.isEnabled = false
    }
    
    @IBAction func deleteTwoAnswers(_ sender: Any) {
        self.fiftyFiftyButton.alpha = 0.5
        self.fiftyFiftyButton.isEnabled = false
        questions[questionNumber].fiftyFifty = true
        let correctAnswer = questions[questionNumber].answers.correctNumberOfQuestion
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
        let correctAnswer = questions[questionNumber].answers.correctNumberOfQuestion
        if correctAnswer == 1 {
            questionNumber += 1
            self.switchQuestion(with: questionNumber)
        } else {
            if trytoErrorFlag == true {
                self.firstAnswerButton.backgroundColor = .red
                self.firstAnswerButton.isEnabled = false
                self.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    @objc func tapOnSecondButton() {
        let correctAnswer = questions[questionNumber].answers.correctNumberOfQuestion
        if correctAnswer == 2 {
            questionNumber += 1
            self.switchQuestion(with: questionNumber)
        } else {
            if trytoErrorFlag == true {
                self.secondAnswerButton.backgroundColor = .red
                self.secondAnswerButton.isEnabled = false
                self.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    @objc func tapOnThirdButton() {
        let correctAnswer = questions[questionNumber].answers.correctNumberOfQuestion
        if correctAnswer == 3 {
            questionNumber += 1
            self.switchQuestion(with: questionNumber)
        } else {
            if trytoErrorFlag == true {
                self.thirdAnswerButton.backgroundColor = .red
                self.thirdAnswerButton.isEnabled = false
                self.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    @objc func tapOnfourthButton() {
        let correctAnswer = questions[questionNumber].answers.correctNumberOfQuestion
        if correctAnswer == 4 {
            questionNumber += 1
            self.switchQuestion(with: questionNumber)
        } else {
            if trytoErrorFlag == true {
                self.fourthAnswerButton.backgroundColor = .red
                self.fourthAnswerButton.isEnabled = false
                self.trytoErrorFlag = false
            } else {
                self.gameOver()
            }
        }
    }
    
    private func switchQuestion(with questionNumber: Int) {
        if self.trytoErrorFlag == true {
            self.trytoErrorFlag = false
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
        self.gameDelegate?.didEndGame(with: questionNumber, allNumberOfQuestion: questions.count)
        
        self.firstAnswerButton.alpha = 0
        self.secondAnswerButton.alpha = 0
        self.thirdAnswerButton.alpha = 0
        self.fourthAnswerButton.alpha = 0
        self.callToFriendButton.alpha = 0
        self.fiftyFiftyButton.alpha = 0
        self.peopleHelpButton.alpha = 0
        self.tryToErrorButton.alpha = 0
        
        self.view.backgroundColor = .red
        self.questionLabel.text = "ТЫ ВЫИГРАЛЛЛ !!! Твой результат - \(self.questionNumber) и твой выигрыш равен \(self.questions[self.questionNumber - 1].countOfMoney)"
        
    }
    
    private func gameOver() {
        self.gameDelegate?.didEndGame(with: questionNumber, allNumberOfQuestion: questions.count)
        
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
            self.questionLabel.text = "Твой результат \(self.questionNumber)            Твой выигрыш равен \(self.questions[self.questionNumber].countOfMoney)"
        }
    }
}
