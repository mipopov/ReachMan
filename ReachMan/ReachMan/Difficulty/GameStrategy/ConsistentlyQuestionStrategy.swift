//
//  ConsistentlyQuestionStrategy.swift
//  ReachMan
//
//  Created by Maxim on 01.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class ConsistentlyQuestionStrategy: CreateQuestionArray {
    private var questions:[Question] = [
        
        Question(questionText: "Что растёт в огороде?", answers: Answers(firstAnswer: "Лук", secondAnswer: "Пистолет", thirdAnswer: "Пулемёт", fourthAnswer: "Луна", correctNumberOfQuestion: 1), questionNumber: 1, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 500),
        
        Question(questionText: "Что делит угол пополам?", answers: Answers(firstAnswer: "Биссектриса", secondAnswer: "Триссектриса", thirdAnswer: "Медиана", fourthAnswer: "Ты", correctNumberOfQuestion: 1), questionNumber: 2, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 1000),
        
        Question(questionText: "О чём писал Грибоедов, отмечая, что он 'нам сладок и приятен' ? ", answers: Answers(firstAnswer: "Дух купечества", secondAnswer: "Дым Отечества", thirdAnswer: "Дар пророчества", fourthAnswer: "Пыл девичества", correctNumberOfQuestion: 2), questionNumber: 3, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 2000),
        
        Question(questionText: "Какого персонажа нет в известной считалке «На золотом крыльце сидели?»", answers: Answers(firstAnswer: "Сапожника", secondAnswer: "Короля", thirdAnswer: "Кузнеца", fourthAnswer: "Портного", correctNumberOfQuestion: 3), questionNumber: 4, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false,countOfMoney: 4000),
        
        Question(questionText: "Что такое десница? ", answers: Answers(firstAnswer: "Бровь", secondAnswer: "Рука ", thirdAnswer: "Шея", fourthAnswer: "Глаз", correctNumberOfQuestion: 2), questionNumber: 5, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 8000),
        
        Question(questionText: "Как назывался каменный монолит, на котором установлен памятник Петру I в Санкт-Петербурге? ", answers: Answers(firstAnswer: "Дом-камень", secondAnswer: "Разрыв-камень", thirdAnswer: "Гром-камень", fourthAnswer: "Гора-камень", correctNumberOfQuestion: 4),
                 questionNumber: 6, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 16_000),
        Question(questionText: "Какое животное имеет второе название — кугуар?", answers: Answers(firstAnswer: "Оцелот", secondAnswer: "Леопард", thirdAnswer: "Пума", fourthAnswer: "Пантера", correctNumberOfQuestion: 3), questionNumber: 7, fiftyFifty: false, peopleHelp: false, tryToError: false, callToFriend: false, countOfMoney: 32_000)
    ]
    
    func createQuestions() -> [Question] {
        return questions
    }
}
