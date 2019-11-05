//
//  CareTracker.swift
//  ReachMan
//
//  Created by Maxim on 21.10.2019.
//  Copyright © 2019 Maxim. All rights reserved.
//

import Foundation

class CareTracker {
    private let encode = JSONEncoder()
    private let decode = JSONDecoder()
    
    private let key = "reachManGames"
    
    func save(_ games: [GameResults]) {
        do {
            let data = try self.encode.encode(games)
            UserDefaults.standard.set(data,forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveGames() -> [GameResults] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        
        do {
            return try self.decode.decode([GameResults].self, from: data)
            
        } catch {
            print(error)
            return []
        }
    }
    
    
}
