//
//  Storyboarded.swift
//  CoordinatorExample
//
//  Created by user on 30/01/2019.
//  Copyright © 2019 Morizo Digital. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}


extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
