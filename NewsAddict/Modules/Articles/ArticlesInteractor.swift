//
//  CategoriesInteractor.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol ArticlesInteractorDelegate: AnyObject {
    func getArticlesData(source: String)
}

class ArticlesInteractor: ArticlesInteractorDelegate {
    var presenter: ArticlesInteractorToPresenterDelegate?
    
    func getArticlesData(source: String) {
        let url = URLComponents(string: "\(BASE_URL)\(ARTICLES_EVERYTHING_ENDPOINT)")
        let params: [String: String] = [
            "sources": source
        ]
        URLSession.shared.request(url: url, expecting: ArticlesModel.self, params: params) { [weak self] result in
            switch result {
            case .success(let articlesData):
                DispatchQueue.main.async {
                    print("Success Getting Data")
                    self?.presenter?.didGetArticlesData(data: articlesData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
