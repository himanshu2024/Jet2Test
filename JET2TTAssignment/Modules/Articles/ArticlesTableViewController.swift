//
//  ArticlesTableViewController.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController, Storyboarded {
    
    private let name = "Articles"
    private let cellId = "ArticleCell"
    private let cellId2 = "MoreCell"
    
    var viewModel: ArticlesViewModelProtocol!
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = name
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        viewModel.getData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.numberOfItem
        }
        else{
            return 1
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleTableViewCell
            
            cell.article = viewModel.getContent(at: indexPath.row)
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1{
            viewModel.getData()
        }
    }
}


extension ArticlesTableViewController: ArticlesView{
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        Alert.showAlert(on: self, with: "Error", message: message)
    }
}
