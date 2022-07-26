//
//  CategoriesPresenter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol CategoriesViewToPresenterDelegate: AnyObject {
    func getCategoryData()
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
}
