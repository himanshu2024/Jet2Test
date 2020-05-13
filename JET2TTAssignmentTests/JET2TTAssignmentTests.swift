//
//  JET2TTAssignmentTests.swift
//  JET2TTAssignmentTests
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import XCTest
@testable import JET2TTAssignment

class JET2TTAssignmentTests: XCTestCase {
    
    var viewModel: ArticlesViewModel!
    var view: ArticlesViewMock!
    var api: ArticlesAPIMock!
    
    
    
    override func setUp() {
        view = ArticlesViewMock()
        api = ArticlesAPIMock()
        viewModel = ArticlesViewModel(view: view, apiService: api)
        viewModel.getData()
    }
    private func setupViewModelWithSuccess() {
        viewModel.getData()
    }
    
    func test_api_shouldCalled() {
        setupViewModelWithSuccess()
        XCTAssertTrue(api.apiCalled)
    }
    
//    func test_apiSuccess_shouldReloadView() {
//        wait(for: [view.expectation], timeout: 10)
//        self.setupViewModelWithSuccess()
//        XCTAssertTrue(self.view.reloadViewCalled)
//
//    }
//
//    func test_numberOfItems(){
//        XCTAssertEqual(viewModel.numberOfItem, 10)
//    }
//
//    func test_contentAtIndex(){
//        XCTAssertEqual(viewModel.getContent(at: 0)?.id, "1")
//        XCTAssertEqual(viewModel.getContent(at: 2)?.id, "3")
//    }
    
    class ArticlesViewMock: ArticlesView {
        var reloadViewCalled = false
        func reloadTableView() {
            reloadViewCalled = true
        }
        
        var showErrorCalledWithArguments: String?
        func showError(message: String) {
            showErrorCalledWithArguments = message
        }
    }
    
    class ArticlesAPIMock: ArticlesInteractor {
        var apiCalled = false
        func fetchArticles(for pageNo: String){
            apiCalled = true
        }
        
    }
    
}
