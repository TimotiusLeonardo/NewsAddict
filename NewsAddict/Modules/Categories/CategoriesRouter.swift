//
//  CategoriesRouter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

protocol CategoriesRouterDelegate: AnyObject {
    //
}

class CategoriesRouter: CategoriesRouterDelegate {
    static func createModule() -> CategoriesViewController {
        let view = CategoriesViewController()
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
        let interactor = CategoriesInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
