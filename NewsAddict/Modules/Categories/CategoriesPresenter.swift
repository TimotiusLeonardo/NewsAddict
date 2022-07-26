//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation
import UIKit

protocol CategoriesViewToPresenterDelegate: AnyObject {
    func getCategoryData()
    func goToSourcesList(category: String)
}

protocol CategoriesInteractorToPresenterDelegate: AnyObject {
    func didGetCategoryData(data: [CategoriesModel])
}

class CategoriesPresenter: CategoriesViewToPresenterDelegate, CategoriesInteractorToPresenterDelegate {
    weak var view: CategoriesViewDelegate?
    var router: CategoriesRouterDelegate?
    var interactor: CategoriesInteractorDelegate?
    
    func getCategoryData() {
        interactor?.getCategoryData()
    }
    
    func didGetCategoryData(data: [CategoriesModel]) {
        view?.updateCategory(data)
    }
    
    func goToSourcesList(category: String) {
        let sourcesVC = SourcesRouter.createModule(category: category)
        router?.goToNextViewController(viewController: view as? UIViewController, nextViewController: sourcesVC)
    }
}
