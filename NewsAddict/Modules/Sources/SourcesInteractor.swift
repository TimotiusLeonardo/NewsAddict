//
//  CategoriesInteractor.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol SourcesInteractorDelegate: AnyObject {
    func getSourcesData(category: String)
}

class SourcesInteractor: SourcesInteractorDelegate {
    var presenter: SourcesInteractorToPresenterDelegate?
    
    func getSourcesData(category: String) {
        let url = URLComponents(string: "\(BASE_URL)\(CATEGORY_SOURCES_ENDPOINT)")
        let params: [String: String] = [
            "category": category
        ]
        URLSession.shared.request(url: url, expecting: SourcesModel.self, params: params) { [weak self] result in
            switch result {
            case .success(let sourcesData):
                DispatchQueue.main.async {
                    print("Success Getting Data")
                    self?.presenter?.didGetSourcesData(data: sourcesData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
