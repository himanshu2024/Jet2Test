//
//  MainCoordinator.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{
var navigationController: UINavigationController
init(navigationController : UINavigationController){
    self.navigationController = navigationController
}

func start() {
    let vc = ArticlesTableViewController.instantiate()
    vc.coordinator = self
    let interactor = ArticlesAPIService()
    let viewModel = ArticlesViewModel(view: vc, apiService: interactor)
    vc.viewModel = viewModel
    interactor.delegate = viewModel
    navigationController.pushViewController(vc, animated: false)
}
}
