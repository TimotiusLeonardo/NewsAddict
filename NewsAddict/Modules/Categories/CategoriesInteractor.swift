//
//  CategoriesInteractor.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol CategoriesInteractorDelegate: AnyObject {
    func getCategoryData()
}

class CategoriesInteractor: CategoriesInteractorDelegate {
    var presenter: CategoriesInteractorToPresenterDelegate?
    
    func getCategoryData() {
        let data = CategoriesModel.getCategoriesData()
        presenter?.didGetCategoryData(data: data)
    }
}
