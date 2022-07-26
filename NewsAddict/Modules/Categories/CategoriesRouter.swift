//
//  CategoriesRouter.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import UIKit

protocol CategoriesRouterDelegate: AnyObject {
    func goToNextViewController(viewController: UIViewController?, nextViewController: UIViewController)
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
    
    func goToNextViewController(viewController: UIViewController?, nextViewController: UIViewController) {
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
