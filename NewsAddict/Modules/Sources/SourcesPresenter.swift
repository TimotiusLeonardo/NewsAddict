//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol SourcesViewToPresenterDelegate: AnyObject {
    func getSourcesData()
    func goToArticlesList(source: String)
    func sortDataBasedOnKeyword(keywords: String, model: SourcesModel?) -> SourcesModel
    func dismiss()
}

protocol SourcesInteractorToPresenterDelegate: AnyObject {
    func didGetSourcesData(data: SourcesModel?)
}

class SourcesPresenter: SourcesViewToPresenterDelegate, SourcesInteractorToPresenterDelegate {
    weak var view: SourcesViewDelegate?
    var router: SourcesRouterDelegate?
    var interactor: SourcesInteractorDelegate?
    
    var category: String = ""
    
    func getSourcesData() {
        interactor?.getSourcesData(category: category)
    }
    
    func didGetSourcesData(data: SourcesModel?) {
        view?.didGetSourcesData(data: data)
    }
    
    func dismiss() {
        router?.dismiss(viewController: view as? UIViewController)
    }
    
    func goToArticlesList(source: String) {
        let articlesVC = ArticlesRouter.createModule(source: source)
        router?.goToNextViewController(viewController: view as? UIViewController, nextViewController: articlesVC)
    }
    
    func sortDataBasedOnKeyword(keywords: String, model: SourcesModel?) -> SourcesModel {
        guard let model = model else {
            return SourcesModel(status: "fail", sources: [])
        }
        
        var sourcesSortContainer = [SourcesDetail]()

        for data in model.sources where data.id.contains(keywords.lowercased()) {
            sourcesSortContainer.append(data)
        }
        
        return SourcesModel(status: "ok", sources: sourcesSortContainer)
    }
}
