//
//  Storyboarded.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
