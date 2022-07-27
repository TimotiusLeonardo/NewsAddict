//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol DetailArticleViewToPresenterDelegate: AnyObject {
    func getDetailArticleData()
    func dismiss()
}

protocol DetailArticleInteractorToPresenterDelegate: AnyObject {
    //
}

class DetailArticlePresenter: DetailArticleViewToPresenterDelegate, DetailArticleInteractorToPresenterDelegate {
    weak var view: DetailArticleViewDelegate?
    var router: DetailArticleRouterDelegate?
    var interactor: DetailArticleInteractorDelegate?
    
    var sourcesId: String = ""
    
    func getDetailArticleData() {
        view?.didGetDetailArticleData(data: interactor?.getArticleData())
    }
    
    func dismiss() {
        router?.dismiss(viewController: view as? UIViewController)
    }
}
