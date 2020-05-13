//
//  Coordinator.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
