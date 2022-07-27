//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol ArticlesViewToPresenterDelegate: AnyObject {
    func getArticlesData()
    func dismiss()
}

protocol ArticlesInteractorToPresenterDelegate: AnyObject {
    func didGetArticlesData(data: ArticlesModel?)
}

class ArticlesPresenter: ArticlesViewToPresenterDelegate, ArticlesInteractorToPresenterDelegate {
    weak var view: ArticlesViewDelegate?
    var router: ArticlesRouterDelegate?
    var interactor: ArticlesInteractorDelegate?
    
    var sourcesId: String = ""
    
    func getArticlesData() {
        interactor?.getArticlesData(source: sourcesId)
    }
    
    func didGetArticlesData(data: ArticlesModel?) {
        view?.didGetArticlesData(data: data)
    }
    
    func dismiss() {
        router?.dismiss(viewController: view as? UIViewController)
    }
}
