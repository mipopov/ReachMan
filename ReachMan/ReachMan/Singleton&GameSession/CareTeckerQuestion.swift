//
//  CareTeckerQuestion.swift
//  ReachMan
//
//  Created by Maxim on 05.11.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class CareTrackerQuestion {
    private let encode = JSONEncoder()
    private let decode = JSONDecoder()
    
    private let questionKey = "quests"
    
    func saveQuestions(_ questions: [Question]) {
        do {
            let data = try self.encode.encode(questions)
            UserDefaults.standard.set(data,forKey: questionKey)
        } catch {
            print(error)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: questionKey) else {return []}
        
        do {
            return try self.decode.decode([Question].self, from: data)
            
        } catch {
            print(error)
            return []
        }
    }
}
