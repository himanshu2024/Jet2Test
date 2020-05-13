//
//  APIService.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

enum APIError: Error{
    case JSONParingError
    case HttpResponseError
    case NoDataError
}

class APIService {
    func get(urlRequest: URLRequest, completion: @escaping (Result<Articles, APIError>) -> Void){
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                let receivedData = data else {
                    print("No data found")
                    completion(.failure(.NoDataError))
                    return
            }
            switch (httpResponse.statusCode)
            {
            case 200:
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Articles.self, from: receivedData)
                    completion(.success(response))
                } catch {
                    print("Error parsing JSON")
                    completion(.failure(.JSONParingError))
                }
            default:
                completion(.failure(.HttpResponseError))
            }
        }
        dataTask.resume()
    }
}

protocol ArticlesInteractor {
    func fetchArticles(for pageNo: String)
}

protocol ArticlesInteractorDelegate: AnyObject {
    func fetchArticlesSuccess(data: Articles)
    func fetchArticlesError(error: String)
}

class ArticlesAPIService:APIService, ArticlesInteractor {
    
    weak var delegate: ArticlesInteractorDelegate?
    
    func fetchArticles(for pageNo: String) {
        let path = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs"
        let queryParams = ["page": pageNo, "limit":"10"]
        
        guard var urlComponent = URLComponents(string: path) else { return }
        var params = [URLQueryItem]()
        for key in queryParams.keys {
            params.append(URLQueryItem(name: key, value: queryParams[key]))
        }
        urlComponent.queryItems = params
        guard let url = urlComponent.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30
        
        get(urlRequest: request) { [weak self] result in
            switch(result){
            case .success(let articles):
                DispatchQueue.main.async {
                self?.delegate?.fetchArticlesSuccess(data: articles)
                }
            case .failure( _):
                DispatchQueue.main.async {
                self?.delegate?.fetchArticlesError(error: "Something went wrong. Please try again")
                }
            }
        }
    }
    
}
