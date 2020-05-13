//
//  ArticlesViewModel.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation
import UIKit

protocol ArticlesView: AnyObject {
    func reloadTableView()
    func showError(message: String)
}

protocol ArticlesViewModelProtocol {
    var numberOfItem : Int{get}
    var numberOfSection : Int{get set}
    init(view: ArticlesView, apiService: ArticlesInteractor)
    func getData()
    func getContent(at index : Int) -> Article?
}

class ArticlesViewModel : ArticlesViewModelProtocol {
    private unowned let view: ArticlesView
    private let apiService: ArticlesInteractor
    private var articles: Articles = [Article]()
    private var pageIndex : Int = 0
    private var isLoading = false
    private var isEmptyData = false
    
    required init(view: ArticlesView, apiService: ArticlesInteractor){
        self.view = view
        self.apiService = apiService
    }
    
    func getData() {
        guard isLoading == false else { return }
        guard isEmptyData == false else { return }
        isLoading = true
        pageIndex += 1
        
        apiService.fetchArticles(for: "\(pageIndex)")
    }
    
    var numberOfItem : Int{
        return articles.count
    }
    
    var numberOfSection : Int = 0
    
    func getContent(at index : Int) -> Article? {
        if index < numberOfItem{
            return articles[index]
        }
        return nil
    }
}

extension ArticlesViewModel: ArticlesInteractorDelegate{
    func fetchArticlesSuccess(data: Articles) {
        self.isLoading = false
        if data.count == 0{
            numberOfSection = 1
            isEmptyData = true
        }
        else{
            numberOfSection = 2
        }
        articles.append(contentsOf: data)
        view.reloadTableView()
    }
    
    func fetchArticlesError(error: String) {
        self.isLoading = false
        view.showError(message: error)
    }
    
    
}
