//
//  ConsistentlyQuestionStrategy.swift
//  ReachMan
//
//  Created by Maxim on 01.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class ConsistentlyQuestionStrategy: CreateQuestionArray {
    private let careTracker = CareTrackerQuestion()

    private var questions:[Question] = [
        
        Question(questionText: "Что растёт в огороде?",firstAnswer: "Лук", secondAnswer: "Пистолет", thirdAnswer: "Пулемёт", fourthAnswer: "Луна", correctNumberOfQuestion: 1),
        
        Question(questionText: "Что делит угол пополам?", firstAnswer: "Биссектриса", secondAnswer: "Триссектриса", thirdAnswer: "Медиана", fourthAnswer: "Ты", correctNumberOfQuestion: 1),
        
        Question(questionText: "О чём писал Грибоедов, отмечая, что он 'нам сладок и приятен' ? ", firstAnswer: "Дух купечества", secondAnswer: "Дым Отечества", thirdAnswer: "Дар пророчества", fourthAnswer: "Пыл девичества", correctNumberOfQuestion: 2),
        
        Question(questionText: "Какого персонажа нет в известной считалке «На золотом крыльце сидели?»", firstAnswer: "Сапожника", secondAnswer: "Короля", thirdAnswer: "Кузнеца", fourthAnswer: "Портного", correctNumberOfQuestion: 3),
        
        Question(questionText: "Что такое десница? ", firstAnswer: "Бровь", secondAnswer: "Рука ", thirdAnswer: "Шея", fourthAnswer: "Глаз", correctNumberOfQuestion: 2),
        
        Question(questionText: "Как назывался каменный монолит, на котором установлен памятник Петру I в Санкт-Петербурге? ", firstAnswer: "Дом-камень", secondAnswer: "Разрыв-камень", thirdAnswer: "Гром-камень", fourthAnswer: "Гора-камень", correctNumberOfQuestion: 4),
        
        Question(questionText: "Какое животное имеет второе название — кугуар?", firstAnswer: "Оцелот", secondAnswer: "Леопард", thirdAnswer: "Пума", fourthAnswer: "Пантера", correctNumberOfQuestion: 3)
    ]
    
    func createQuestions() -> [Question] {
        questions = questions + careTracker.retrieveQuestions()
        return questions
    }
}
