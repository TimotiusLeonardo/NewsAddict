//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol ArticlesViewToPresenterDelegate: AnyObject {
    func goToDetailArticlePage(article: ArticlesDetail?)
    func getArticlesData(withKeyword: String?)
    func dismiss()
    func refreshData()
}

protocol ArticlesInteractorToPresenterDelegate: AnyObject {
    func didGetArticlesData(data: ArticlesModel?)
}

class ArticlesPresenter: ArticlesViewToPresenterDelegate, ArticlesInteractorToPresenterDelegate {
    weak var view: ArticlesViewDelegate?
    var router: ArticlesRouterDelegate?
    var interactor: ArticlesInteractorDelegate?
    
    var page = 1
    var sourcesId: String = ""
    var withKeyword: String = ""
    
    func getArticlesData(withKeyword: String?) {
        if let withKeyword = withKeyword {
            self.withKeyword = withKeyword
            page = 1
        }
        
        interactor?.getArticlesData(source: sourcesId, page: page, withKeyword: self.withKeyword)
    }
    
    func refreshData() {
        page = 1
    }
    
    func didGetArticlesData(data: ArticlesModel?) {
        view?.didGetArticlesData(data: data)
        page += 1
    }
    
    func dismiss() {
        router?.dismiss(viewController: view as? UIViewController)
    }
    
    func goToDetailArticlePage(article: ArticlesDetail?) {
        let detailVC = DetailArticleRouter.createModule(article: article)
        router?.goToNextViewController(viewController: view as? UIViewController, nextViewController: detailVC)
    }
}
